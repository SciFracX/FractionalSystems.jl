Base.print(io::IO, G::FOTF) = show(io, G)

import Base.show

function Base.show(io::IO, G::FOTF)
    println(typeof(G))
    print("\n")
    #=
    for (i, _) in enumerate(G.num)
        j=G.num[i]
        l=G.nn[i]
        if i == 1
            if j == 1
                print("s^{$l}")
            else
                print("$(showfirstsign(j))s^"*"{$l}")
            end
        else
            print("$(showsign(j))s^"*"{$l}")
        end
    end
    =#
    print(polyshow(G.num, G.nn))
    print("\n")
    G.ioDelay == 0 ? println("-----"^max(length(G.den), length(G.num))) : println("-----"^max(length(G.den), length(G.num))*" exp($(G.ioDelay)*s)")
    print(polyshow(G.den, G.nd))
end


function polyshow(p, np)
    if length(np) == 0
        p=0
        np=0
    end

    ii = sortperm(np, rev=true)
    np = sort(np, rev=true)
    P=""
    p=p[ii]

    for i=1:length(p)
        P=P*"+"*"$(p[i])"*"s^"*"{$(np[i])}"
    end

    P = P[2:end]
    P = replace(P, "s^{0}" => "")
    P = replace(P, "s^{0.0}" => "")
    P = replace(P, "^{1}" => "")
    P = replace(P, "+-" => "-")
    P = replace(P, "+1s" => "+s")
    P = replace(P, "-1s" => "-s")
    
    return P
end
#=
function fotfshow(G, key)
    strN = polyshow(G.num, G.nn)
    str = strN
    strD = polyshow(G.den, G.nd)
    nn = length(strN)
    ns=0

    if nn == 1 && strN == "0"
        if key == 0
            show(strN)
        end
    else
        ns == length(strD)
        nm = max(nn, ns)
        if key == 0
            show(" "^Int64(floor((nm-nn)/2))*"$(strN)")
        end
        ss=[]
        T=G.ioDelay
        if T > 0
            ss="exp(-$(T)*s)"
        end
        if cmp(strD, "1") !=0
            if T>0
                str="("*"$str"*")*"*"$(ss)"*"/("*"$strD"
            else
                str="("*"$str"*")/("*"$strD"*")"
            end
            str=replace(replace(str, "{"=>""), "}"=>"")
            if key == 0
                show("-"^nm*"$ss")
                show(" "^Int64(floor((nm-ns)/2))*"$strD")
            end
        end
    end
    show(str)
end
=#

# Handling the signs of the polynomials's coefficients
function showsign(a)
    if a > 0
        return " + "*"$a"
    elseif a < 0
        return " - "*"$(abs(a))"
    end
end
function showfirstsign(a)
    if a > 0
        return "$a"
    elseif a < 0
        return "-"*"$(abs(a))"
    end
end