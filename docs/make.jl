using Documenter, Example

makedocs(modules = [Example], sitename = "simple-julia-project")

deploydocs(repo = "github.com/t-young31/simple-julia-project.git")
