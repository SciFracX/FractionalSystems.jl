using FractionalSystems
using Documenter

DocMeta.setdocmeta!(FractionalSystems, :DocTestSetup, :(using FractionalSystems); recursive=true)

makedocs(;
    modules=[FractionalSystems],
    authors="Qingyu Qu",
    repo="https://github.com/SciFracX/FractionalSystems.jl/blob/{commit}{path}#{line}",
    sitename="FractionalSystems.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://SciFracX.github.io/FractionalSystems.jl",
        assets = ["assets/favicon.ico"],
    ),
    pages = [
        "FractionalSystems.jl" => "index.md",
        "Get Started" => "get_started.md",
        "Root Locus" => "rlocus.md",
        "Frequency Analysis" => "frequency.md",
        "Lyapunov Exponents Spectrum" => "flyapunovexp.md",
        "Conversation" => "conversation.md"
    ],
)

deploydocs(;
    repo="github.com/SciFracX/FractionalSystems.jl",
    devbranch="master",
)
