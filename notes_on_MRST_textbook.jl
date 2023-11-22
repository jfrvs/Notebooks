### A Pluto.jl notebook ###
# v0.19.32

using Markdown
using InteractiveUtils

# ╔═╡ c3d07ef6-966d-4605-a088-126d6d3a268d
using PlutoUI

# ╔═╡ c1947be0-8483-11ee-0c3a-dd321d248a1c
md"""

# An Introduction to Reservoir Simulation Using MATLAB/GNU Octave

"""

# ╔═╡ 27cbc82e-42e5-4d0f-b426-b3ec24efaa43
md"""

## *Introduction*

"""

# ╔═╡ 0e921510-f3a9-49d6-8ebf-70203578cf99
md"""
> A modelagem do escoamento que ocorre abaixo da terra abrange alguns dos mais importantes desafios tecnológicos do nosso tempo
"""

# ╔═╡ 9d485f11-00f2-4865-8eba-86f8806803d9
md"""
### Motivação
"""

# ╔═╡ 80c325c8-c455-4109-9726-228c309dd2ca
md"""
- Administração e manejo de reservas de água potável;
    - Definições de níveis de uso sustentáveis;
    - Controle e rastreamento de poluentes;
- Armazenamento de gases de efeito estufa como $CO_2$;
    - Quantificação do tempo de permanência do gás dentro dos reservatórios;
    - Verificação de possíveis rotas de escape do gás, que pode incluir reservatórios de água potável, e como mitigar esta situação;
- Recuperação de hidrocarbonetos;
    - Aumento da recuperação de campos existentes;
    - Viabilização de estratégias alternativas para recuperação de hidrocarbonetos;
    - Viabilização de fontes alternativas de hidrocarbonetos;
- Outros;
    - Energia geotérmica;
    - Armazenamento de resíduos nucleares.
"""

# ╔═╡ 77e61485-07f5-4ab4-aa2f-ff62baa2d027
md"""
### Definições
"""

# ╔═╡ eaf11da5-c15e-4110-9734-86eb27d83a2f
md"""
- Modelagem de Reservatórios
> Uso de ferramentas computacionais para abstrair um modelo de um reservatório, incluindo definições de rocha, fluidos e estruturas de transporte, que permita a realização de predições de interesse, seja relacionado a produção de hidrocarbonetos, ou armazenamento de gases relacionados ao efeito estufa
"""

# ╔═╡ 420cab68-f525-43d5-9944-aca5ac3e2e6e
md"""

## *Petroleum Recovery*

"""

# ╔═╡ d4d014d5-b467-4672-b425-87d28e5156d2
md"""
No contexto de reservatórios de petróleo, podemos imaginar estes como esponjas rígidas, encapsuladas por material impermeável, cujos poros são interconectados e preenchidos com hidrocarbonetos, tanto em fase líquida como em fase gasosa. A presença de mais de uma fase é determinadas pela pressão do reservatório, se a mesma for abaixo do ponto de bolha, duas fases surgiram, uma gasosa e uma líquida.

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_001.png"))

Considerando a inserção de um poço cujo fundo se encontra no nível de líquido:

Se a diferença de pressão entre o fundo e o topo do poço for suficiente, naturalmente ocorrerá um escoamento de líquido para dentro do poço rumo ao topo. Este processo leva a uma diminuição gradativa de pressão dentro do reservatório. Naturalmente, isto leva a uma menor recuperação, pois a diferença de pressão é a força motriz da recuperação. Entretanto, a partir desta diminuição, vários fenômenos podem acontecer que auxiliam a manutenção da pressão do reservatório:

- Compensação de Água
> A diminuição da pressão leva a uma expansão da água sob a camada de petróleo. Normalmente esta expansão é muito pequena, porém, se houver um aquífero suficientemente grande, esta expansão pode auxiliar a diminuir a queda de pressão. 
- Compensação de Gás em Solução
> A diminuição da pressão leva ao surgimento de bolhas de gás em solução que forçam o petróleo em direção ao poço, e, neste, melhoram a mobilidade e aumentam a recuperação momentaneamente
- Compensação de Tampão de Gás
> Conforme o gás se separa a medida que a pressão diminui, ele se acumula no topo do reservatório e progressivamente expande, auxiliando a manter a pressão do reservatório

Entre estes efeitos, o menos significativo é a Compensação de Gás em Solução, e o mais significativo é a combinação dos outros dois, denominado Compensação Combinada.

Os mecanismos até aqui descritos são mecanismos de produção primária, responsáveis por até 30% da recuperação. Para aumenta a recuperação, é necessário métodos mais avançados. 

"""

# ╔═╡ 3b664063-3400-4411-94dc-351dbcc1744b
md"""
Métodos de produção secundária utilizam de alguns dos efeitos de compensação, porém de forma artificial, onde água e/ou gás é injetado.

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_002.png"))

Existem vários desafios que dificultam que todo o petróleo seja recuperado, como a diferença de viscosidade entre as fases, o que dificulta a varredura completa do reservatório. Neste caso, injeção de vapor e polímeros pode ser uma alternativa, caracterizando métodos de produção terciária.
"""

# ╔═╡ 72759784-667c-469f-928a-9723d21875e3
md"""

## *Reservoir Simulation*

"""

# ╔═╡ b9ad9290-f6a1-4320-91e0-f73c059c09ae
md"""
Simulação de reservatórios consiste na combinação de três modelos: um modelo geológico, um modelo de escoamento e um modelo de poço/mecanismo de fluxo

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_003.png"))


"""

# ╔═╡ cf9baeab-33d7-4928-81ad-1647ee16965a
md"""
Desafios incluem:

- Dificuldade em obter uma caracterização completa da rocha que compõe o reservatório
- Limitações na quantidade de céulas para descrição do sistema (Performance vs Precisão)
    - Upscaling de modelos

"""

# ╔═╡ 6f8f320e-801e-47b3-b129-917df9f8d65b
md"""
> Occam’s principle: a simulation model should be as simple as possible, but not simpler
"""

# ╔═╡ 4a7416f8-560d-4948-a57a-29898eae37ff
md"""

## *Modelling Reservoir Rocks*

"""

# ╔═╡ 2e86c358-388f-49e2-b2bc-194aef8a389b
md"""
Os sedimentos são partículas de rocha, areia, argila, carbonato ou material orgânico que se acumulam em bacias oceânicas ou lacustres, sendo transportados pelo ar ou água, na forma de ventos e correntes marinhas, por exemplo.

Os sedimentos sob efeito de pressão de camadas superiores passa por transformações físico-químicas formando rochas sedimentares cujas propriedades depende da natureza da transformação e do tipo de sedimento que compõe a rocha. 

- *Sandstone* e *Limestone*: Volume de poros maior, possibilitando o escoamento maior de fluidos. O primeiro tem como origem a erosão de pedras, e o segundo de esqueletos de organismos marinhos, levando a um alto teor de cálcio. 
- *Mudrock* e Rochas Químicas: A primeira se trata de uma combinação de argila e lama, e a segunda, sais precipitados, ambos apresentam volume de poros baixíssimo, levando a pouco ou nenhum escoamento de fluidos
"""

# ╔═╡ dadc290c-5df0-4afe-82ae-33cd896ec214
md"""
O petróleo e o gás natural são formados a partir de restos orgânicos de plantas e animais acumulados há milhões de anos, enterrados sob sedimentos e expostos a altas temperaturas e pressões que transformaram o material orgânico em hidrocarbonetos.

Os hidrocarbonetos migraram através das rochas porosas até encontrarem uma armadilha geológica que impedisse seu movimento ascendente, formando assim os reservatórios. A composição e a qualidade do petróleo e do gás dependem das condições de formação, como o tipo de material orgânico, a temperatura, a pressão e o tempo de maturação. O petróleo e o gás podem ocorrer em diferentes fases, dependendo da pressão e da temperatura.
"""

# ╔═╡ 93efebad-8d44-40bb-83b0-ac174d973a08
md"""
## Propriedades de Rochas
"""

# ╔═╡ fae33d87-bd21-4608-8aff-1756091f15ed
md"""
- Porosidade: É a fração do volume total ocupada por espaços vazios (poros). É uma propriedade importante para determinar a capacidade de armazenamento de fluidos de uma rocha. A porosidade pode ou não ser descrita como função da pressão.

- Permeabilidade: É a medida da facilidade com que um fluido pode fluir através de uma rocha. Ela pode ser descrita como um escalar, ou como um tensor, dependendo da natureza do sistema.

"""

# ╔═╡ 86103796-449e-478b-bb74-2698b2596418
md"""
## *Grids* 
"""

# ╔═╡ a8722d9f-da10-4ff0-b38a-db32a040aea3
md"""
Um *grid* é uma abstração que busca representar um volume ou superfície utilizando formas simples denominadas células.

Grids podem ser estruturados ou não estruturados:

- Grids estruturados são representados por células que contém apenas um formato.
    - Grids estruturados regulares vão além, onde além todas as células devem ter a mesma dimensão.
- Grids não-estruturados misturam diferentes formas
- MRST trata todos os grids de forma completa, como se fossem não-estruturados

Grid regular:

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_004.png"))

Grid não regular:

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_005.png"))
"""

# ╔═╡ 6271f89f-6bff-474c-8083-ade11129e3b4
md"""
Domínios ficticios permitem a extrair uma forma complexa de um sistema retangular ou cúbico, utilizando uma informação verdadeiro/falso em cada célula indicando se ela é ou não parte do domínio:

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_006.png"))

"""

# ╔═╡ ffaeeb06-0992-45b0-aa58-203d59256d4b
md"""
Grids não-estruturados utilizam algoritmo de tesselação de Delaunay e Voronoi para construção de geometrias mais complexas. É possívelutilizar outros algoritmos e o MRST permite também a utilização de um gerador externo de grids.

$(PlutoUI.LocalResource("W:\\Notebooks\\figure_007.png"))

"""

# ╔═╡ 82d3f1f7-9a14-4d87-8bc7-8b78c4e2b607
md"""
*Stratigraphic Grids*

to be continued
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
PlutoUI = "~0.7.53"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "2221109544af0af0a1dbe6ee2a9707ab16223647"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "91bd53c39b9cbfb5ef4b015e8b582d344532bd0a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.0"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.10.11"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.21+4"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a935806434c9d4c506ba941871b327b96d41f2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "db8ec28846dbf846228a32de5a6912c63e2052e3"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.53"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "03b4c25b43cb84cee5c90aa9b5ea0a78fd848d2f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.0"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "00805cd429dcb4870060ff49ef443486c262e38e"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.1"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.8.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"
"""

# ╔═╡ Cell order:
# ╠═c3d07ef6-966d-4605-a088-126d6d3a268d
# ╠═c1947be0-8483-11ee-0c3a-dd321d248a1c
# ╠═27cbc82e-42e5-4d0f-b426-b3ec24efaa43
# ╠═0e921510-f3a9-49d6-8ebf-70203578cf99
# ╠═9d485f11-00f2-4865-8eba-86f8806803d9
# ╠═80c325c8-c455-4109-9726-228c309dd2ca
# ╠═77e61485-07f5-4ab4-aa2f-ff62baa2d027
# ╠═eaf11da5-c15e-4110-9734-86eb27d83a2f
# ╠═420cab68-f525-43d5-9944-aca5ac3e2e6e
# ╠═d4d014d5-b467-4672-b425-87d28e5156d2
# ╠═3b664063-3400-4411-94dc-351dbcc1744b
# ╟─72759784-667c-469f-928a-9723d21875e3
# ╠═b9ad9290-f6a1-4320-91e0-f73c059c09ae
# ╠═cf9baeab-33d7-4928-81ad-1647ee16965a
# ╠═6f8f320e-801e-47b3-b129-917df9f8d65b
# ╠═4a7416f8-560d-4948-a57a-29898eae37ff
# ╠═2e86c358-388f-49e2-b2bc-194aef8a389b
# ╠═dadc290c-5df0-4afe-82ae-33cd896ec214
# ╠═93efebad-8d44-40bb-83b0-ac174d973a08
# ╠═fae33d87-bd21-4608-8aff-1756091f15ed
# ╠═86103796-449e-478b-bb74-2698b2596418
# ╠═a8722d9f-da10-4ff0-b38a-db32a040aea3
# ╠═6271f89f-6bff-474c-8083-ade11129e3b4
# ╠═ffaeeb06-0992-45b0-aa58-203d59256d4b
# ╠═82d3f1f7-9a14-4d87-8bc7-8b78c4e2b607
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
