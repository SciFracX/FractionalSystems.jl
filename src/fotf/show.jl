Base.print(io::IO, G::FOTF) = show(io, G)

function Base.show(io::IO, G::FOTF)
    println(typeof(G))
    print("\n")
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
    print("\n")

    G.ioDelay == 0 ? println("--------"^length(G.den)) : println("---------"^length(G.den)*" exp($(G.ioDelay)*s)")

    for (i, _) in enumerate(G.den)
        j=G.den[i]
        l=G.nd[i]
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