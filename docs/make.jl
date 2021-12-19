using FractionalSystems
using Documenter

DocMeta.setdocmeta!(FractionalSystems, :DocTestSetup, :(using FractionalSystems); recursive=true)

makedocs(;
    modules=[FractionalSystems],
    authors="Qingyu Qu",
    repo="https://github.com/ErikQQY/FractionalSystems.jl/blob/{commit}{path}#{line}",
    sitename="FractionalSystems.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://ErikQQY.github.io/FractionalSystems.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/ErikQQY/FractionalSystems.jl",
    devbranch="main",
)
