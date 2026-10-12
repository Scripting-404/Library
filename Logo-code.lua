return function(ctx)
    local new = ctx.new
    local tween = ctx.tween
    local tweenAfter = ctx.tweenAfter
    local GRID = ctx.GRID
    local CENTER = ctx.CENTER
    local GRID_R = ctx.GRID_R
    local STROKE = ctx.STROKE
    local CHARS = ctx.CHARS

    local G = {}
    function G.hyp(a, b) return math.sqrt(a*a + b*b) end
    function G.seg(u, v, x1, y1, x2, y2)
        local dx, dy = x2-x1, y2-y1
        local len = dx*dx + dy*dy
        if len <= 1e-9 then return G.hyp(u-x1, v-y1) end
        local t = math.clamp(((u-x1)*dx + (v-y1)*dy)/len, 0, 1)
        return G.hyp(u-(x1+t*dx), v-(y1+t*dy))
    end
    function G.line(u, v, pts)
        local m = math.huge
        for i=1,#pts-1 do
            local a,b=pts[i],pts[i+1]
            m=math.min(m,G.seg(u,v,a[1],a[2],b[1],b[2]))
        end
        return m
    end
    function G.poly(u, v, pts)
        local m=math.huge
        for i=1,#pts do
            local a,b=pts[i],pts[i % #pts + 1]
            m=math.min(m,G.seg(u,v,a[1],a[2],b[1],b[2]))
        end
        return m
    end
    function G.inside(u,v,pts)
        local result=false
        local j=#pts
        for i=1,#pts do
            local xi,yi=pts[i][1],pts[i][2]
            local xj,yj=pts[j][1],pts[j][2]
            if (yi>v) ~= (yj>v) and u < (xj-xi)*(v-yi)/(yj-yi)+xi then result=not result end
            j=i
        end
        return result
    end
    function G.rbox(u,v,cx,cy,hx,hy,r)
        local qx=math.abs(u-cx)-(hx-r)
        local qy=math.abs(v-cy)-(hy-r)
        return G.hyp(math.max(qx,0),math.max(qy,0))+math.min(math.max(qx,qy),0)-r
    end
    function G.ring(u,v,cx,cy,r,w) return math.abs(G.hyp(u-cx,v-cy)-r) <= (w or STROKE) end
    function G.ellipse(u,v,ang,a,b)
        local ca,sa=math.cos(ang),math.sin(ang)
        local x=u*ca+v*sa; local y=-u*sa+v*ca
        return (x/a)^2+(y/b)^2
    end
    function G.arc(cx,cy,rx,ry,t0,t1,n)
        local pts={}
        for i=0,n do
            local t=t0+(t1-t0)*i/n
            pts[#pts+1]={cx+rx*math.cos(t),cy+ry*math.sin(t)}
        end
        return pts
    end
    local HEX={{0,-.86},{.745,-.43},{.745,.43},{0,.86},{-.745,.43},{-.745,-.43}}
    local SHIELD={{0,-.88},{.74,-.62},{.74,.06},{.46,.52},{0,.9},{-.46,.52},{-.74,.06},{-.74,-.62}}
    local BOLT={{.18,-.92},{-.52,.08},{-.06,.08},{-.2,.92},{.52,-.16},{.06,-.16}}
    local HEART={}
    for i=0,47 do
        local t=i/48*2*math.pi
        local hx=16*math.sin(t)^3
        local hy=13*math.cos(t)-5*math.cos(2*t)-2*math.cos(3*t)-math.cos(4*t)
        HEART[#HEART+1]={hx/17.5,-(hy+2.5)/17.5}
    end
    local PULSE={{-.9,.05},{-.45,.05},{-.3,-.35},{-.1,.5},{.1,-.7},{.3,.2},{.45,.05},{.9,.05}}
    local CURSOR={{-.5,-.85},{-.5,.6},{-.14,.3},{.08,.86},{.3,.77},{.08,.22},{.55,.22}}
    local PLAY={{-.22,-.5},{.54,0},{-.22,.5}}
    local SHAPES = {}

    -- Original logo keys, retained for compatibility.
    SHAPES.roblox = function(u,v)
        local a=math.rad(-14); local ru=u*math.cos(a)-v*math.sin(a); local rv=u*math.sin(a)+v*math.cos(a)
        local m=math.max(math.abs(ru),math.abs(rv)); return (m<=.78 and m>.36) and 2 or 0
    end
    SHAPES.lua = function(u,v)
        local r=G.hyp(u+.08,v-.08)
        if G.hyp(u-.7,v+.7)<=.17 then return 1 end
        if r<=.78 and not (r>=.4 and r<=.52) then return 2 end
        return 0
    end
    SHAPES.cyber = function(u,v)
        if G.poly(u,v,HEX)<=STROKE then return 1 end
        local d=math.abs(u)+math.abs(v)
        return (d<=.36 or math.abs(d-.52)<=.04) and 1 or 0
    end
    SHAPES.code = function(u,v)
        local w=.07
        if G.seg(u,v,-.30,-.56,-.84,0)<=w or G.seg(u,v,-.84,0,-.30,.56)<=w then return 1 end
        if G.seg(u,v,.30,-.56,.84,0)<=w or G.seg(u,v,.84,0,.30,.56)<=w then return 1 end
        if G.seg(u,v,.16,-.66,-.16,.66)<=w then return 1 end
        return 0
    end
    SHAPES.hello = function(u,v,cx,cy)
        local d=G.rbox(u,v,0,-.12,.88,.60,.24)
        if math.abs(d)<=STROKE then return 1 end
        local tx=cx+11; local gy=math.floor((cy+9)/2)
        if tx>=0 and tx<10 then
            local row=({"X...X","X...X","X...X","XXXXX","X...X","X...X","X...X"})[gy+1]
            if row and row:sub(math.floor(tx/2)+1,math.floor(tx/2)+1)=="X" then return 1 end
        end
        return 0
    end
    SHAPES.core = function(u,v)
        if math.abs(G.rbox(u,v,0,0,.52,.52,.08))<=STROKE or math.max(math.abs(u),math.abs(v))<=.26 then return 1 end
        for _,k in ipairs({-.3,0,.3}) do
            if (math.abs(u-k)<=.04 and math.abs(v)>.5 and math.abs(v)<=.86) or (math.abs(v-k)<=.04 and math.abs(u)>.5 and math.abs(u)<=.86) then return 1 end
        end
        return 0
    end
    SHAPES.shield = function(u,v)
        if G.poly(u,v,SHIELD)<=STROKE or G.seg(u,v,-.30,0,-.08,.24)<=.07 or G.seg(u,v,-.08,.24,.32,-.22)<=.07 then return 1 end
        return 0
    end
    SHAPES.lock = function(u,v)
        local d=G.rbox(u,v,0,.3,.56,.46,.1)
        if d<=0 then
            if G.hyp(u,v-.24)<=.1 or (math.abs(u)<=.04 and v>=.24 and v<=.5) then return 0 end
            return d < -STROKE and 2 or 1
        end
        if v<=-.1 and math.abs(G.hyp(u,v+.1)-.34)<=.065 then return 1 end
        return 0
    end
    SHAPES.bolt = function(u,v) return G.inside(u,v,BOLT) and 1 or 0 end
    SHAPES.terminal = function(u,v)
        local d=G.rbox(u,v,0,0,.9,.68,.1)
        if math.abs(d)<=STROKE or (d<0 and math.abs(v+.42)<=.04) then return 1 end
        for _,x in ipairs({-.7,-.54,-.38}) do if G.hyp(u-x,v+.55)<=.055 then return 1 end end
        if G.seg(u,v,-.55,-.2,-.25,.04)<=.06 or G.seg(u,v,-.25,.04,-.55,.28)<=.06 or G.seg(u,v,-.1,.34,.36,.34)<=.06 then return 1 end
        return 0
    end
    SHAPES.gear = function(u,v)
        local r=G.hyp(u,v); local a=math.atan2(v,u)
        if math.abs(r-.52)<=.09 or math.abs(r-.2)<=.07 or (r>=.58 and r<=.86 and math.cos(8*a)>.25) then return 1 end
        return 0
    end
    SHAPES.globe = function(u,v)
        local r=G.hyp(u,v)
        if math.abs(r-.84)<=STROKE then return 1 end
        if r<.84 and (math.abs(v)<=.045 or math.abs(u)<=.045 or math.abs(math.abs(v)-.44)<=.04 or math.abs((u/.42)^2+(v/.84)^2-1)<=.22) then return 1 end
        return 0
    end
    SHAPES.key = function(u,v)
        if math.abs(G.hyp(u+.42,v+.36)-.3)<=.07 or G.seg(u,v,-.2,-.14,.74,.8)<=.065 or G.seg(u,v,.5,.56,.66,.4)<=.06 or G.seg(u,v,.34,.4,.5,.24)<=.06 then return 1 end
        return 0
    end
    SHAPES.atom = function(u,v)
        if G.hyp(u,v)<=.13 then return 1 end
        for _,a in ipairs({0,math.pi/3,2*math.pi/3}) do if math.abs(G.ellipse(u,v,a,.88,.32)-1)<=.2 then return 1 end end
        return 0
    end
    SHAPES.braces = function(u,v)
        local x=math.abs(u); local pts={{-.38,-.8},{-.62,-.66},{-.62,-.14},{-.84,0},{-.62,.14},{-.62,.66},{-.38,.8}}
        if G.line(x,v,pts)<=.07 then return 1 end
        for _,dx in ipairs({-.2,0,.2}) do if G.hyp(u-dx,v)<=.055 then return 1 end end
        return 0
    end
    SHAPES.brackets = function(u,v)
        local x=math.abs(u)
        if G.line(x,v,{{-.4,-.7},{-.8,-.7},{-.8,.7},{-.4,.7}})<=.07 or G.seg(u,v,-.14,0,.14,0)<=.06 or G.seg(u,v,0,-.14,0,.14)<=.06 then return 1 end
        return 0
    end
    SHAPES.database = function(u,v)
        if math.abs(u)>.57 and math.abs(u)<.68 and v>=-.5 and v<=.7 then return 1 end
        for _,p in ipairs({G.arc(0,-.5,.62,.22,0,2*math.pi,28),G.arc(0,-.1,.62,.22,0,math.pi,16),G.arc(0,.3,.62,.22,0,math.pi,16),G.arc(0,.7,.62,.22,0,math.pi,16)}) do if G.line(u,v,p)<=.055 then return 1 end end
        return 0
    end
    SHAPES.cloud = function(u,v)
        local d=math.min(G.hyp(u+.42,v-.12)-.3,G.hyp(u+.02,v+.14)-.42,G.hyp(u-.44,v-.12)-.3,G.rbox(u,v,.02,.31,.76,.17,.17))
        if math.abs(d)<=STROKE then return 1 end; return d<0 and 2 or 0
    end
    SHAPES.wifi = function(u,v)
        local dx,dy=u,v-.6; local r=G.hyp(dx,dy)
        if r<=.1 then return 1 end
        if dy<0 and -dy>=math.abs(dx)*.9 then for _,rr in ipairs({.38,.68,.98}) do if math.abs(r-rr)<=.065 then return 1 end end end
        return 0
    end
    SHAPES.heart = function(u,v) if G.poly(u,v,HEART)<=STROKE then return 1 end; return G.inside(u,v,HEART) and 2 or 0 end
    SHAPES.bug = function(u,v)
        local x=math.abs(u); local b=G.hyp(u/.4,(v-.12)/.55)
        if math.abs(b-1)<=.1 or (b<1 and x<=.035) or math.abs(G.hyp(u,v+.62)-.2)<=.06 then return 1 end
        if G.seg(x,v,.38,-.2,.8,-.38)<=.055 or G.seg(x,v,.4,.12,.84,.12)<=.055 or G.seg(x,v,.36,.44,.78,.62)<=.055 or G.seg(x,v,.1,-.78,.3,-.92)<=.05 then return 1 end
        return 0
    end
    SHAPES.branch = function(u,v)
        if G.seg(u,v,-.32,-.54,-.32,.54)<=.065 or G.seg(u,v,-.32,.22,.4,-.2)<=.065 then return 1 end
        for _,p in ipairs({{-.32,-.7},{-.32,.7},{.4,-.38}}) do if math.abs(G.hyp(u-p[1],v-p[2])-.17)<=.06 then return 1 end end
        return 0
    end
    SHAPES.pulse = function(u,v) return G.line(u,v,PULSE)<=.065 and 1 or 0 end
    SHAPES.eye = function(u,v)
        if math.abs(u)<=.92 then local h=.55*(1-(u/.92)^2); if math.abs(math.abs(v)-h)<=.06 then return 1 end end
        local r=G.hyp(u,v); return (r<=.17 or math.abs(r-.34)<=.05) and 1 or 0
    end
    SHAPES.cursor = function(u,v) if G.poly(u,v,CURSOR)<=STROKE then return 1 end; return G.inside(u,v,CURSOR) and 2 or 0 end
    SHAPES.download = function(u,v)
        if G.seg(u,v,0,-.8,0,.32)<=.07 or G.line(u,v,{{-.4,-.08},{0,.34},{.4,-.08}})<=.07 or G.line(u,v,{{-.72,.12},{-.72,.72},{.72,.72},{.72,.12}})<=.065 then return 1 end
        return 0
    end
    SHAPES.play = function(u,v) return (math.abs(G.hyp(u,v)-.84)<=STROKE or G.inside(u,v,PLAY)) and 1 or 0 end
    SHAPES.hash = function(u,v)
        if G.seg(u,v,-.2,-.75,-.38,.75)<=.07 or G.seg(u,v,.38,-.75,.2,.75)<=.07 or G.seg(u,v,-.7,-.28,.7,-.28)<=.07 or G.seg(u,v,-.7,.28,.7,.28)<=.07 then return 1 end
        return 0
    end

    -- Additional logos/icons.
    SHAPES.server = function(u,v)
        for _,cy in ipairs({-.48,0,.48}) do
            local d=G.rbox(u,v,0,cy,.72,.2,.08)
            if math.abs(d)<=STROKE or (d<0 and G.hyp(u+.48,v-cy)<=.045) then return 1 end
        end
        return 0
    end
    SHAPES.layers = function(u,v)
        local p1={{0,-.72},{.78,-.3},{0,.12},{-.78,-.3}}
        local p2={{-.72,.02},{0,.42},{.72,.02}}
        local p3={{-.72,.32},{0,.72},{.72,.32}}
        if G.poly(u,v,p1)<=STROKE or G.line(u,v,p2)<=STROKE or G.line(u,v,p3)<=STROKE then return 1 end
        return 0
    end
    SHAPES.rocket = function(u,v)
        local body={{0,-.88},{.36,-.44},{.4,.12},{.18,.46},{-.18,.46},{-.4,.12},{-.36,-.44}}
        if G.poly(u,v,body)<=STROKE or G.inside(u,v,body) and G.hyp(u,v+.34)<.12 then return 1 end
        if G.seg(u,v,-.34,.1,-.68,.48)<=.06 or G.seg(u,v,.34,.1,.68,.48)<=.06 or G.seg(u,v,-.18,.42,-.26,.78)<=.06 or G.seg(u,v,.18,.42,.26,.78)<=.06 then return 1 end
        return 0
    end
    SHAPES.star = function(u,v)
        local p={}
        for i=0,9 do local a=-math.pi/2+i*math.pi/5; local r=(i%2==0) and .86 or .38; p[#p+1]={r*math.cos(a),r*math.sin(a)} end
        if G.poly(u,v,p)<=STROKE or G.inside(u,v,p) then return 1 end; return 0
    end
    SHAPES.check = function(u,v) return (G.seg(u,v,-.65,.02,-.18,.48)<=.09 or G.seg(u,v,-.18,.48,.72,-.52)<=.09) and 1 or 0 end
    SHAPES.close = function(u,v) return (G.seg(u,v,-.58,-.58,.58,.58)<=.09 or G.seg(u,v,-.58,.58,.58,-.58)<=.09) and 1 or 0 end
    SHAPES.search = function(u,v)
        if math.abs(G.hyp(u+.18,v-.18)-.48)<=.085 or G.seg(u,v,.16,.16,.72,.72)<=.09 then return 1 end; return 0
    end
    SHAPES.bell = function(u,v)
        local pts=G.arc(0,-.1,.58,.62,math.pi,2*math.pi,24)
        if G.line(u,v,pts)<=.065 or G.seg(u,v,-.58,-.1,-.58,.42)<=.065 or G.seg(u,v,.58,-.1,.58,.42)<=.065 or G.seg(u,v,-.72,.45,.72,.45)<=.065 or G.ring(u,v,0,.62,.1,.06) then return 1 end
        return 0
    end
    SHAPES.folder = function(u,v)
        local p={{-.82,-.48},{-.22,-.48},{-.05,-.28},{.82,-.28},{.72,.58},{-.72,.58}}
        if G.poly(u,v,p)<=STROKE or G.inside(u,v,p) and math.abs(v-.35)<.06 then return 1 end; return 0
    end
    SHAPES.file = function(u,v)
        local p={{-.55,-.82},{.22,-.82},{.58,-.48},{.58,.82},{-.55,.82}}
        if G.poly(u,v,p)<=STROKE or G.seg(u,v,.22,-.82,.22,-.48)<=.06 or G.seg(u,v,.22,-.48,.58,-.48)<=.06 then return 1 end
        for _,y in ipairs({-.1,.16,.42}) do if G.seg(u,v,-.32,y,.34,y)<=.05 then return 1 end end
        return 0
    end
    SHAPES.user = function(u,v)
        if math.abs(G.hyp(u,v+.38)-.22)<=.07 then return 1 end
        local d=G.hyp(u,v-.44)
        if d>.47 and d<.82 and v>.05 then return 1 end
        return 0
    end
    SHAPES.users = function(u,v)
        if math.abs(G.hyp(u+.28,v+.35)-.17)<=.055 or math.abs(G.hyp(u-.28,v+.35)-.17)<=.055 then return 1 end
        if G.seg(u,v,-.82,.58,-.58,.08)<=.06 or G.seg(u,v,-.58,.08,-.12,.08)<=.06 or G.seg(u,v,-.12,.08,.05,.58)<=.06 or G.seg(u,v,.12,.58,.3,.08)<=.06 or G.seg(u,v,.3,.08,.65,.08)<=.06 or G.seg(u,v,.65,.08,.82,.58)<=.06 then return 1 end
        return 0
    end
    SHAPES.camera = function(u,v)
        if math.abs(G.rbox(u,v,0,.08,.82,.52,.12))<=STROKE or math.abs(G.hyp(u,v-.06)-.25)<=.06 or G.seg(u,v,-.36,-.46,-.16,-.68)<=.06 or G.seg(u,v,-.16,-.68,.12,-.68)<=.06 then return 1 end
        return 0
    end
    SHAPES.calendar = function(u,v)
        if math.abs(G.rbox(u,v,0,.05,.72,.68,.08))<=STROKE or G.seg(u,v,-.72,-.28,.72,-.28)<=.06 then return 1 end
        for _,x in ipairs({-.42,0,.42}) do for _,y in ipairs({-.02,.28}) do if G.rbox(u,v,x,y,.06,.06,.02)<=0 then return 1 end end end
        if G.seg(u,v,-.38,-.82,-.38,-.5)<=.06 or G.seg(u,v,.38,-.82,.38,-.5)<=.06 then return 1 end
        return 0
    end
    SHAPES.clock = function(u,v)
        if math.abs(G.hyp(u,v)-.78)<=STROKE or G.seg(u,v,0,0,0,-.46)<=.07 or G.seg(u,v,0,0,.38,.2)<=.07 then return 1 end; return 0
    end
    SHAPES.mail = function(u,v)
        if math.abs(G.rbox(u,v,0,0,.82,.56,.08))<=STROKE or G.seg(u,v,-.76,-.48,0,.08)<=.07 or G.seg(u,v,0,.08,.76,-.48)<=.07 then return 1 end; return 0
    end
    SHAPES.link = function(u,v)
        local a=math.abs(G.ellipse(u,v,math.rad(-35),.55,.23)-1)<=.23 and math.abs(u+.34)>.22
        local b=math.abs(G.ellipse(u,v,math.rad(-35),.55,.23)-1)<=.23 and math.abs(u-.34)>.22
        if a or b or G.seg(u,v,-.26,.24,.26,-.24)<=.09 then return 1 end; return 0
    end
    SHAPES.trophy = function(u,v)
        if G.seg(u,v,-.36,-.58,.36,-.58)<=.06 or G.seg(u,v,-.36,-.58,-.3,.12)<=.06 or G.seg(u,v,.36,-.58,.3,.12)<=.06 or G.seg(u,v,-.3,.12,.3,.12)<=.06 or G.seg(u,v,0,.12,0,.58)<=.06 or G.seg(u,v,-.34,.58,.34,.58)<=.06 then return 1 end
        if G.arc(-.38,-.28,.22,.25,-math.pi/2,math.pi/2,14) and (G.line(u,v,G.arc(-.53,-.24,.24,.25,-math.pi/2,math.pi/2,14))<=.06 or G.line(u,v,G.arc(.53,-.24,.24,.25,math.pi/2,3*math.pi/2,14))<=.06) then return 1 end
        return 0
    end
    SHAPES.leaf = function(u,v)
        local p=G.arc(0,0,.66,.82,-math.pi/2,math.pi/2,22)
        local q=G.arc(0,0,.66,.82,math.pi/2,3*math.pi/2,22)
        if G.line(u,v,p)<=.07 or G.line(u,v,q)<=.07 or G.seg(u,v,-.55,.55,.48,-.48)<=.065 then return 1 end; return 0
    end
    SHAPES.sun = function(u,v)
        if math.abs(G.hyp(u,v)-.4)<=.07 then return 1 end
        for i=0,7 do local a=i*math.pi/4; if G.seg(u,v,.55*math.cos(a),.55*math.sin(a),.84*math.cos(a),.84*math.sin(a))<=.06 then return 1 end end
        return 0
    end
    SHAPES.moon = function(u,v)
        if math.abs(G.hyp(u+.08,v)-.72)<=.07 and not (u>.12 and G.hyp(u-.35,v)<.62) then return 1 end; return 0
    end
    SHAPES.flame = function(u,v)
        local p={{0,-.9},{.26,-.48},{.62,-.12},{.57,.42},{.32,.76},{-.3,.76},{-.62,.32},{-.52,-.1},{-.28,.08},{-.18,-.34}}
        if G.poly(u,v,p)<=STROKE or G.inside(u,v,p) and G.hyp(u,v-.3)<.25 then return 1 end; return 0
    end
    SHAPES.diamond = function(u,v)
        local p={{0,-.86},{.72,-.28},{0,.86},{-.72,-.28}}
        if G.poly(u,v,p)<=STROKE or G.seg(u,v,-.72,-.28,.72,-.28)<=.05 or G.seg(u,v,0,-.86,0,.86)<=.05 then return 1 end; return 0
    end
    SHAPES.crown = function(u,v)
        local p={{-.78,-.42},{-.48,.42},{0,-.02},{.48,.42},{.78,-.42},{.62,.66},{-.62,.66}}
        if G.poly(u,v,p)<=STROKE or G.ring(u,v,-.78,-.5,.08,.06) or G.ring(u,v,0,-.1,.08,.06) or G.ring(u,v,.78,-.5,.08,.06) then return 1 end; return 0
    end
    SHAPES.chat = function(u,v)
        local p={{-.78,-.58},{.78,-.58},{.78,.35},{.18,.35},{-.28,.76},{-.22,.35},{-.78,.35}}
        if G.poly(u,v,p)<=STROKE then return 1 end
        for _,x in ipairs({-.38,0,.38}) do if G.hyp(u-x,v+.1)<=.055 then return 1 end end
        return 0
    end
    SHAPES.music = function(u,v)
        if G.seg(u,v,.28,-.72,.28,.34)<=.07 or G.seg(u,v,.28,-.72,.72,-.82)<=.07 or G.seg(u,v,.28,-.28,.72,-.38)<=.07 or G.ring(u,v,-.02,.44,.2,.07) or G.ring(u,v,.48,.28,.2,.07) then return 1 end; return 0
    end
    SHAPES.command = function(u,v)
        if G.ring(u,v,-.43,-.43,.2,.07) or G.ring(u,v,.43,.43,.2,.07) or G.seg(u,v,-.3,-.3,.3,.3)<=.07 or G.seg(u,v,.32,-.32,.5,-.5)<=.07 then return 1 end; return 0
    end
    SHAPES.infinity = function(u,v)
        local d=math.min(math.abs(G.ellipse(u,v,math.rad(35),.5,.35)-1),math.abs(G.ellipse(u,v,math.rad(-35),.5,.35)-1))
        return d<=.22 and 1 or 0
    end
    SHAPES.circuit = function(u,v)
        local lines={{{-.72,-.48},{-.28,-.48},{-.28,0},{.2,0},{.2,.48},{.72,.48}},{{-.72,.48},{-.52,.48},{-.52,.08}},{{.72,-.48},{.5,-.48},{.5,-.08},{.2,-.08}}}
        for _,p in ipairs(lines) do if G.line(u,v,p)<=.06 then return 1 end end
        for _,p in ipairs({{-.72,-.48},{-.72,.48},{.72,.48},{.72,-.48},{-.52,.08},{.2,0},{.2,.48}}) do if G.ring(u,v,p[1],p[2],.09,.055) then return 1 end end
        return 0
    end
    SHAPES.upload = function(u,v)
        if G.seg(u,v,0,.46,0,-.58)<=.07 or G.line(u,v,{{-.38,-.2},{0,-.6},{.38,-.2}})<=.07 or G.line(u,v,{{-.72,.2},{-.72,.68},{.72,.68},{.72,.2}})<=.065 then return 1 end; return 0
    end
    SHAPES.refresh = function(u,v)
        local p=G.arc(0,0,.68,.68,math.rad(45),math.rad(320),28)
        if G.line(u,v,p)<=.08 or G.inside(u,v,{{.42,-.78},{.84,-.68},{.7,-.28}}) or G.inside(u,v,{{-.42,.78},{-.84,.68},{-.7,.28}}) then return 1 end; return 0
    end
    SHAPES.home = function(u,v)
        if G.line(u,v,{{-.82,-.02},{0,-.72},{.82,-.02}})<=.07 or G.line(u,v,{{-.58,-.12},{-.58,.68},{.58,.68},{.58,-.12}})<=.07 or G.rbox(u,v,0,.36,.16,.32,.04)<=0 then return 1 end; return 0
    end
    SHAPES.pin = function(u,v)
        local d=G.hyp(u,v+.28)
        if math.abs(d-.52)<=.07 and v<.3 or G.seg(u,v,0,.24,0,.88)<=.07 or G.ring(u,v,0,-.28,.18,.06) then return 1 end; return 0
    end
    SHAPES.sliders = function(u,v)
        for _,y in ipairs({-.48,0,.48}) do if G.seg(u,v,-.76,y,.76,y)<=.06 then return 1 end end
        for _,p in ipairs({{-.3,-.48},{.34,0},{-.12,.48}}) do if math.abs(G.rbox(u,v,p[1],p[2],.11,.14,.05))<=.06 then return 1 end end
        return 0
    end
    SHAPES.shieldcheck = function(u,v)
        if G.poly(u,v,SHIELD)<=STROKE or G.seg(u,v,-.32,.02,-.08,.26)<=.065 or G.seg(u,v,-.08,.26,.34,-.22)<=.065 then return 1 end; return 0
    end
    SHAPES.sparkle = function(u,v)
        local a=math.abs(u); local b=math.abs(v)
        if G.seg(u,v,0,-.9,0,.9)<=.055 and a<.12 or G.seg(u,v,-.7,0,.7,0)<=.055 and b<.12 then return 1 end
        if G.seg(u,v,-.55,-.78,.55,.78)<=.04 and math.abs(u+v*.704)<.06 then return 1 end
        if G.ring(u,v,.52,-.48,.12,.05) then return 1 end; return 0
    end
    SHAPES.heartpulse = function(u,v)
        if G.poly(u,v,HEART)<=.07 then return 1 end
        if G.line(u,v,{{-.78,.04},{-.4,.04},{-.2,-.24},{0,.32},{.2,-.08},{.36,.04},{.7,.04}})<=.065 then return 1 end
        return 0
    end
    SHAPES.pause = function(u,v)
        if G.rbox(u,v,-.25,0,.14,.58,.05)<=0 or G.rbox(u,v,.25,0,.14,.58,.05)<=0 then return 1 end; return 0
    end
    SHAPES.stop = function(u,v) return G.rbox(u,v,0,0,.6,.6,.1)<=0 and 1 or 0 end
    SHAPES.volume = function(u,v)
        if G.poly(u,v,{{-.8,-.26},{-.48,-.26},{-.08,-.58},{-.08,.58},{-.48,.26},{-.8,.26}})<=STROKE then return 1 end
        if G.line(u,v,G.arc(-.02,0,.4,.48,-math.pi/3,math.pi/3,18))<=.06 or G.line(u,v,G.arc(-.02,0,.65,.72,-math.pi/3,math.pi/3,18))<=.06 then return 1 end; return 0
    end
    SHAPES.shieldstar = function(u,v)
        if G.poly(u,v,SHIELD)<=STROKE then return 1 end
        local p={}; for i=0,9 do local a=-math.pi/2+i*math.pi/5; local r=(i%2==0) and .34 or .15; p[#p+1]={r*math.cos(a),.05+r*math.sin(a)} end
        return G.poly(u,v,p)<=.045 and 1 or 0
    end
    SHAPES.infinitycode = function(u,v)
        local d=math.min(math.abs(G.ellipse(u,v,math.rad(35),.48,.33)-1),math.abs(G.ellipse(u,v,math.rad(-35),.48,.33)-1))
        if d<=.2 or G.seg(u,v,-.12,-.66,-.32,.66)<=.055 or G.seg(u,v,.32,-.66,.12,.66)<=.055 then return 1 end; return 0
    end

    local SHAPE_NAMES = {
        "roblox","lua","cyber","code","hello","core","shield","lock","bolt","terminal","gear","globe","key","atom",
        "braces","brackets","database","cloud","wifi","heart","bug","branch","pulse","eye","cursor","download","play","hash",
        "server","layers","rocket","star","check","close","search","bell","folder","file","user","users","camera","calendar","clock","mail","link","trophy","leaf","sun","moon","flame","diamond","crown","chat","music","command","infinity","circuit","upload","refresh","home","pin","sliders","shieldcheck","sparkle","heartpulse","pause","stop","volume","shieldstar","infinitycode"
    }

    local function buildLogo(holder, shapeName, accent, secondary, textSize)
        local fn=SHAPES[shapeName]
        if not fn then
            warn("[Scripting 404] Unknown logo shape: " .. tostring(shapeName))
            return { alive=false, cells={} }
        end
        local state={alive=true,cells={}}
        for y=1,GRID do
            for x=1,GRID do
                local cx,cy=x-CENTER,y-CENTER
                local fill=fn(cx/GRID_R,cy/GRID_R,cx,cy)
                if fill==2 and (x+y)%2~=0 then fill=0 end
                if fill~=0 then
                    local color=(math.random()<.6) and accent or secondary
                    local label=new("TextLabel",{
                        AnchorPoint=Vector2.new(.5,.5),
                        Size=UDim2.fromScale(1/GRID,1/GRID),
                        Position=UDim2.fromScale(math.random(-250,-40)/100,math.random(-40,140)/100),
                        BackgroundTransparency=1,
                        Text=CHARS[math.random(1,#CHARS)],
                        TextSize=textSize,
                        Font=Enum.Font.Code,
                        TextColor3=color,
                        TextTransparency=1,
                        ZIndex=9,
                    },holder)
                    state.cells[#state.cells+1]={label=label,color=color}
                    local delay=((x+y)/(GRID*2))*.5+math.random()*.2
                    tweenAfter(label,delay,.45+math.random()*.1,{
                        Position=UDim2.fromScale((x-.5)/GRID,(y-.5)/GRID),
                        TextTransparency=0,
                    },Enum.EasingStyle.Quint)
                end
            end
        end
        task.spawn(function()
            while state.alive and #state.cells>0 do
                for _=1,math.clamp(math.floor(#state.cells/40),6,14) do
                    local c=state.cells[math.random(1,#state.cells)]
                    if c.label and c.label.Parent then
                        c.label.Text=CHARS[math.random(1,#CHARS)]
                        c.label.TextColor3=Color3.fromRGB(255,255,255)
                        tween(c.label,.35,{TextColor3=c.color},Enum.EasingStyle.Sine)
                    end
                end
                task.wait(.07)
            end
        end)
        return state
    end
    local function dissolveLogo(state)
        if not state then return end
        state.alive=false
        for _,cell in ipairs(state.cells or {}) do
            if cell.label and cell.label.Parent then
                local pos=cell.label.Position
                tweenAfter(cell.label,math.random()*.2,.5,{
                    Position=UDim2.fromScale(pos.X.Scale+math.random(150,300)/100,pos.Y.Scale+math.random(-20,20)/100),
                    TextTransparency=1,
                },Enum.EasingStyle.Quad)
            end
        end
        task.delay(1,function()
            for _,cell in ipairs(state.cells or {}) do
                if cell.label and cell.label.Parent then cell.label:Destroy() end
            end
        end)
    end
    return { Build=buildLogo, Dissolve=dissolveLogo, Names=SHAPE_NAMES }
end
