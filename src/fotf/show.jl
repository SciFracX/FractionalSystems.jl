Base.print(G::FOTF) = show(G)

function Base.show(io::IO, G::FOTF)
    println(typeof(G))
    print("\n")
    numstr = polyshow(G.num, G.nn)
    denstr = polyshow(G.den, G.nd)
    print(numstr)
    print("\n")
    maxlengthstr = max(length(numstr), length(denstr))
    G.ioDelay == 0 ? println("-"^maxlengthstr) : println("-"^maxlengthstr*" exp($(G.ioDelay)*s)")
    print(denstr)
end


function polyshow(p, np)
    if typeof(p) <: Number
        return p
    end

    if length(np) == 0
        p=0
        np=0
    end

    ii = sortperm(np, rev=true)
    np = sort(np, rev=true)
    P = ""
    p = p[ii]

    for i = 1:length(p)
        P = P*"+"*"$(p[i])"*"s^"*"{$(np[i])}"
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