var documenterSearchIndex = {"docs":
[{"location":"get_started/#Get-Started","page":"Get Started","title":"Get Started","text":"","category":"section"},{"location":"get_started/#Fractional-transfer-function","page":"Get Started","title":"Fractional transfer function","text":"","category":"section"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"After installed the FractionalSystems.jl package and using it, we can now create a fractional order transfer function:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)\nFOTF\n\ns^{0.3} + 2s^{0.4}\n------------------\ns^{0.5} + 2s^{0.6}","category":"page"},{"location":"get_started/#Fractional-order-state-space","page":"Get Started","title":"Fractional order state space","text":"","category":"section"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"In FractionalSystems.jl, it is easy to create a fractional order state space:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> sys = foss([-5 0; 0 -5],[2; 2],[3 3],[0], 0.5, 1, 1, 1)\nFOSS\n\nA =\n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nDescriptor matrix:\n\nE =\n1\n\nTime delay is 1\nα = 0.5\nInitial state vector x₀ = 1","category":"page"},{"location":"conversation/#Conversation-with-ControlSystems.jl","page":"Conversation","title":"Conversation with ControlSystems.jl","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"While Fractional systems are generalization of integer order control systems, so it si convinient to transform between FractionalSystems.jl and ControlSystems.jl.","category":"page"},{"location":"conversation/#Conversation-between-Transfer-Function","page":"Conversation","title":"Conversation between Transfer Function","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"To achieve the translation of Transfer Function and Fractional Order Transfer Function,  we only need to use the command fotf2cotf to transform the fractional order transfer function to integer order transfer function:","category":"page"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"julia> G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78])\nFOTF\n\ns^{0.1} + 2s^{0.2} + 3s^{0.34}\n---------------------\n4s^{0.65} + 5s^{0.67} + 6s^{0.78}\n\njulia> fotf2cotf(G)\nTransferFunction{Continuous, ControlSystems.SisoRational{Float64}}        \n3.0s^34 + 2.0s^20 + 1.0s^10\n---------------------------\n6.0s^78 + 5.0s^67 + 4.0s^65\n\nContinuous-time transfer function model","category":"page"},{"location":"conversation/#Conversation-between-State-Space","page":"Conversation","title":"Conversation between State Space","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"To transform the fractional order state space to integer state space, we can use the foss2ss function:","category":"page"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"julia> s = foss([-5 0; 0 -5], [2; 2], [3 3],[0], 0.5, 2, [2], 2)\nFOSS\n\nA =\n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nDescriptor matrix:\n\nE =\n[2]\n\nTime delay is 2\nα = 0.5\nInitial state vector x₀ = 2\n\njulia> foss2ss(s)\nStateSpace{Continuous, Int64}\nA = \n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nContinuous-time state-space model","category":"page"},{"location":"rlocus/#Root-Locus","page":"Root Locus","title":"Root Locus","text":"","category":"section"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Root locus is an important analysis method in systems, we can use the root locus to judge whether teh system is stable or not, it is also very convienent to draw root locus in FractionalSystems.jl:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Let's see if we have a fractional order transfer function model:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s)=frac1s^35+10s^28+35s^21+50s^14+24s^07","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"All we need to do is abstract the model and plot the locus:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G = fotf([1], [0], [1, 10, 35, 50, 24], [3.5, 2.8, 2.1, 1.4, 0.7])\nrlocus(G)","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"(Image: rlocus)","category":"page"},{"location":"rlocus/#Another-example","page":"Root Locus","title":"Another example","text":"","category":"section"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Let's see the fractional order transfer function is:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s) = frac-2s^063-42s^3501+38s^242+26s^1798+25s^131+15","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"We need to know the root locus of the fractional order model is in fact the root locus of the commensurate order model based on the original fractional order model, so in this example, while the base order is lambda=s^0001, which means the highest order of the commensurate order model is 3501!! It is troublesome to handle this in ControlSystems.jl, so we can approximate the order as:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s)=frac-2s^06-42s^35+38s^24+26s^18+25s^13+15","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Then abstract the model! Plot the root locus!","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"b=fotf([-2, -4], [0.6, 0], [2, 3.8, 2.6, 2.5, 1.5], [3.5, 2.4, 1.8, 1.3, 0])\nrlocus(b)","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"(Image: yarlocus)","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"CurrentModule = FractionalSystems","category":"page"},{"location":"#FractionalSystems","page":"FractionalSystems.jl","title":"FractionalSystems","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Hello there👋!","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"FractionalSystems.jl is a Julia package aiming at providing support for fractional order system analysis.","category":"page"},{"location":"#Installation","page":"FractionalSystems.jl","title":"Installation","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"To install FractionalCalculus, please open Julia REPL and press ] key to use package mode and then type the following command:","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Pkg> add FractionalSystems","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Or if you want to experience the latest version of FractionalSystems.jl:","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Pkg> add FractionalSystems#master","category":"page"},{"location":"#Motivation","page":"FractionalSystems.jl","title":"Motivation","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Why we create the FractionalSystems.jl?","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"The current Fractional computing packages are encoded using Matlab and has not been updated for quite a long time\nThere are many good algorithms and valuable designs out there in papers have not been implemented so far\nWe admire the features and performance of the Julia language\nWe need the help of the existing fractional computing relating packages(Also maintained by SciFracX community)","category":"page"},{"location":"#Notice","page":"FractionalSystems.jl","title":"Notice","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"FractionalSystems.jl is evolved from FOMCON and FOTF, which are Matlab toolboxs used to serve Matlab. In the future, we plan to integrate all the current fractional order modeling toolboxs, such as Ninteger toolbox, CRONE toolbox and with the help of Julia, build a performant and feature rich toolbox.","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"info: WIP\nFractionalSystems.jl is under heavy construction, some API or docs might change a lot.","category":"page"}]
}
