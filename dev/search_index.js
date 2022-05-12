var documenterSearchIndex = {"docs":
[{"location":"get_started/#Get-Started","page":"Get Started","title":"Get Started","text":"","category":"section"},{"location":"get_started/#Fractional-transfer-function","page":"Get Started","title":"Fractional transfer function","text":"","category":"section"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"After installed the FractionalSystems.jl package and using it, we can now create a fractional order transfer function:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> tf = fotf([1, 2], [0.3, 0.4], [1, 2], [0.5, 0.6], 2)\nFOTF\n\ns^{0.3} + 2s^{0.4}\n------------------ exp(-2*s)     \ns^{0.5} + 2s^{0.6}","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"Or simply by passing the strings to the definition of fotf:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> fotf(\"s\")","category":"page"},{"location":"get_started/#Basic-arithmetic-operations","page":"Get Started","title":"Basic arithmetic operations","text":"","category":"section"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"In FractionalSysetms.jl we can perform basic arithmetic operations on fractional order transfer functions:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"* Addition\n* Subtraction\n* Multiplication\n* Division","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> a = fotf([1, 2], [0.3, 0.4], [3, 4], [0.5, 0.6])\nFOTF\n\n2s^{0.4}+s^{0.3}\n-----------------\n4s^{0.6}+3s^{0.5}\njulia> b=fotf([1, 2], [0.3, 0.4], [2, 3], [0.4, 0.5])\nFOTF\n\n2s^{0.4}+s^{0.3}\n-----------------\n3s^{0.5}+2s^{0.4}\n\njulia> a+b\nFOTF\n\n8s^{0.3}+16s^{0.2}+10s^{0.10000000000000003}+2\n----------------------------------------------\n12s^{0.39999999999999997}+17s^{0.3}+6s^{0.2}\n\njulia> a-b\n-8s^{0.3}-4s^{0.2}+4s^{0.10000000000000003}+2\n---------------------------------------------\n12s^{0.39999999999999997}+17s^{0.3}+6s^{0.2}\n\njulia> a*b\nFOTF\n\n4s^{0.20000000000000007}+4s^{0.09999999999999998}+1\n-----------------------------------------------------------\n12s^{0.5000000000000001}+17s^{0.4}+6s^{0.30000000000000004}\n\njulia> a/b\nFOTF\n\n6.0s^{0.20000000000000007}+7.0s^{0.09999999999999998}+2.0\n---------------------------------------------------------------------------------\n8.0s^{0.29999999999999993}+10.0s^{0.20000000000000007}+3.0s^{0.09999999999999998}","category":"page"},{"location":"get_started/#Fractional-order-state-space","page":"Get Started","title":"Fractional order state space","text":"","category":"section"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"In FractionalSystems.jl, it is easy to create fractional order state space:","category":"page"},{"location":"get_started/","page":"Get Started","title":"Get Started","text":"julia> sys = foss([-5 0; 0 -5], [2; 2], [3 3], [0], 0.5, 1, 1, 1)\nFOSS\n\nA =\n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nDescriptor matrix:\n\nE =\n1\n\nTime delay is 1\nα = 0.5\nInitial state vector x₀ = 1","category":"page"},{"location":"conversation/#Conversation-with-ControlSystems.jl","page":"Conversation","title":"Conversation with ControlSystems.jl","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"While Fractional systems are generalization of integer order control systems, so it is also convenient to transform between FractionalSystems.jl and ControlSystems.jl.","category":"page"},{"location":"conversation/#Conversation-between-Transfer-Function","page":"Conversation","title":"Conversation between Transfer Function","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"To achieve the translation of Transfer Function and Fractional Order Transfer Function,  we only need to use the command fotf2cotf to transform the fractional order transfer function to integer order transfer function:","category":"page"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"julia> G = fotf([1, 2, 3], [0.1, 0.2, 0.34], [4, 5, 6], [0.65, 0.67, 0.78])\nFOTF\n\ns^{0.1} + 2s^{0.2} + 3s^{0.34}\n---------------------\n4s^{0.65} + 5s^{0.67} + 6s^{0.78}\n\njulia> fotf2cotf(G)\nTransferFunction{Continuous, ControlSystems.SisoRational{Float64}}        \n3.0s^34 + 2.0s^20 + 1.0s^10\n---------------------------\n6.0s^78 + 5.0s^67 + 4.0s^65\n\nContinuous-time transfer function model","category":"page"},{"location":"conversation/#Conversation-between-State-Space","page":"Conversation","title":"Conversation between State Space","text":"","category":"section"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"To transform the fractional order state space to integer state space, we can use the foss2ss function:","category":"page"},{"location":"conversation/","page":"Conversation","title":"Conversation","text":"julia> s = foss([-5 0; 0 -5], [2; 2], [3 3],[0], 0.5, 2, [2], 2)\nFOSS\n\nA =\n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nDescriptor matrix:\n\nE =\n[2]\n\nTime delay is 2\nα = 0.5\nInitial state vector x₀ = 2\n\njulia> foss2ss(s)\nStateSpace{Continuous, Int64}\nA = \n -5   0\n  0  -5\nB =\n 2\n 2\nC =\n 3  3\nD =\n 0\n\nContinuous-time state-space model","category":"page"},{"location":"flyapunovexp/#Lyapunov-Epxponent","page":"Lyapunov Exponents","title":"Lyapunov Epxponent","text":"","category":"section"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"Lyapunov exponent is a quantity we can use to determine the property of a fractional order systems. In  FractionalSystems.jl, we provide performant and easy-to-use API to compute the Lyapunov exponent of the given fractional order system.","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"Let's see, if given a Rabinovich-Fabrikant system:","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"D^alpha_1 x=y(z-1+z^2)+gamma x\nD^alpha_2 y=x(3z+1-x^2)+gamma y\nD^alpha_3 z=-2z(alpha+xy)","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"using FractionalSystems\n\nfunction RF(du, u, t)\n    du[1] = u[2]*(u[3]-1+u[1]*u[1])+0.1*u[1];\n    du[2] = u[1]*(3*u[3]+1-u[1]*u[1])+0.1*u[2];\n    du[3] = -2*u[3]*(0.98+u[1]*u[2]);\n    du\nend\nLE, tspan = LE, tspan=FOLyapunov(RF, 0.98, 0, 0.02, 300, [0.1; 0.1; 0.1], 0.005, 1000)","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"The output would be:","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"[0.24348568050729053; 0.007633838815648884; -2.01869669467999]\n[0.07157300142223447; 0.006017955472054196; -1.8449594097070114]\n[0.02954807020615554; 0.005293698652556152; -1.8022533152602607]\n[0.052957613549810205; -0.008645340965388692; -1.811729795783463]\n[0.012973090534610711; -0.007161228086636709; -1.7732510305991271]\n[0.031221399670846705; 0.014443534887429972; -1.813104301211669]\n[0.060185947864662345; -0.008121864429315997; -1.8194985262036134]\n[0.05827747678224907; -0.02236380502528364; -1.8033534921771472]\n[0.05562485202522532; 0.012690387635387365; -1.8357552036479894]\n[0.04968563412570279; -0.0009995900467388353; -1.8161301570507935]\n[0.07100223089628108; 0.0019123252012412822; -1.8403598219695858]\n[0.06326817286599998; -0.019433471090304896; -1.8112809983953584]\n[0.06705094763635554; -0.0015939955503458177; -1.8329059006298087]\n[0.059724759994251635; -0.0031386869537530426; -1.8240358860199872]\n[0.06111650166568285; 0.0038981396237095034; -1.8324646820425692]","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"The computed LE is the Lyapunov exponent of this system.","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"julia> LE\n3×1 Matrix{Float64}:\n  0.06111650166568285\n  0.0038981396237095034\n -1.8324646820425692","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"To visualize the Lyapunov exponent, what just need to plot our LE:","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"plot(tspan, LE[1, :])\nplot!(tspan, LE[2, :])\nplot!(tspan, LE[3, :])","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"(Image: RFLE)","category":"page"},{"location":"flyapunovexp/#Another-4-D-example:","page":"Lyapunov Exponents","title":"Another 4-D example:","text":"","category":"section"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"Let's see the Piece-Wise Continuous (PWC) fractional order system:","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"D^q x_1=-x_1+x_2\nD^q x_2=-x_3textsgn(x_1)+x_4\nD^q x_3=x_1-a\nD^q x_4=-bx_2","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"By following what we have done before, we can easily get the Lyapunov exponent of this PWC system.","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"using FractionalSystems, Plots\n\nfunction Danca(du, u, t)\n    du[1] = -u[1]+u[2]\n    du[2] = -u[3]*sign(u[1])+u[4]\n    du[3] = abs(u[1])-1\n    du[4] = -0.5*u[2]\n    du\nend\n\nLE, tspan=FOLyapunov(Danca, 0.98, 0, 0.02, 300, [0.1; 0.1; 0.1; 0.1], 0.005, 1000)\n\nplot(tspan, LE[1, :])\nplot!(tspan, LE[2, :])\nplot!(tspan, LE[3, :])\nplot!(tspan, LE[4, :])","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"By plot the Lyapunov exponent:","category":"page"},{"location":"flyapunovexp/","page":"Lyapunov Exponents","title":"Lyapunov Exponents","text":"(Image: PWC)","category":"page"},{"location":"frequency/#Frequency-domain-analysis","page":"Frequency Analysis","title":"Frequency domain analysis","text":"","category":"section"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"Frequency analysis is a powerful tool in system analysis, we can access the properties of the system in frequency domain to reveal the stability, gain margin, phase margin etc.","category":"page"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"In FractionalSystems.jl, it is also easy to transform the system to frequency domain:","category":"page"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"julia> freqresp(s, G)","category":"page"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"The freqresp function return the frequency response of the fractional order systems.","category":"page"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"tip: ```logspace``` substitute\nIn Julia, there are no logspace(a, b) API, we can use exp10.(range(a, b, length=50)) instead.","category":"page"},{"location":"frequency/#Bode-plot","page":"Frequency Analysis","title":"Bode plot","text":"","category":"section"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"To generate a bode plot of a FOTF object, we can directly use bodeplot(g::FOTF) to analysis the frequency properties of the FOTF:","category":"page"},{"location":"frequency/","page":"Frequency Analysis","title":"Frequency Analysis","text":"julia> bodeplot(G)","category":"page"},{"location":"rlocus/#Root-Locus","page":"Root Locus","title":"Root Locus","text":"","category":"section"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Root locus is an important analysis method in systems, we can use the root locus to judge whether the system is stable or not, it is also very convienent to draw root locus plot with FractionalSystems.jl:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Let's see if we have a fractional order transfer function model:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s)=frac1s^35+10s^28+35s^21+50s^14+24s^07","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"All we need to do is abstract the model and plot the locus:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G = fotf([1], [0], [1, 10, 35, 50, 24], [3.5, 2.8, 2.1, 1.4, 0.7])\nrlocus(G)","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"(Image: rlocus)","category":"page"},{"location":"rlocus/#Another-example","page":"Root Locus","title":"Another example","text":"","category":"section"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Let's see the fractional order transfer function is:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s) = frac-2s^063-42s^3501+38s^242+26s^1798+25s^131+15","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"We need to know the root locus of the fractional order model is in fact the root locus of the commensurate order model based on the original fractional order model, so in this example, while the base order is lambda=s^0001, which means the highest order of the commensurate order model is 3501!! It is troublesome to handle this in ControlSystems.jl, so we can approximate the order as:","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"G(s)=frac-2s^06-42s^35+38s^24+26s^18+25s^13+15","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"Then abstract the model! Plot the root locus!","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"b=fotf([-2, -4], [0.6, 0], [2, 3.8, 2.6, 2.5, 1.5], [3.5, 2.4, 1.8, 1.3, 0])\nrlocus(b)","category":"page"},{"location":"rlocus/","page":"Root Locus","title":"Root Locus","text":"(Image: yarlocus)","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"CurrentModule = FractionalSystems","category":"page"},{"location":"#FractionalSystems","page":"FractionalSystems.jl","title":"FractionalSystems","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Hello there👋!","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"FractionalSystems.jl is a Julia package aiming at providing support for fractional order system analysis.","category":"page"},{"location":"#Installation","page":"FractionalSystems.jl","title":"Installation","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"To install FractionalCalculus, please open Julia REPL and press ] key to use package mode and then type the following command:","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"pkg> add FractionalSystems","category":"page"},{"location":"#Motivation","page":"FractionalSystems.jl","title":"Motivation","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"Why we create the FractionalSystems.jl?","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"The current Fractional computing packages are encoded using Matlab and has not been updated for quite a long time\nThere are many good algorithms and valuable designs out there in papers have not been implemented so far\nWe admire the features and performance of the Julia language\nWe need the help of the existing fractional computing relating packages(Also maintained by SciFracX community)","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"tip: Tip\nYou can also use this docs as a resources for learning fractional order mathematics.","category":"page"},{"location":"#Notice","page":"FractionalSystems.jl","title":"Notice","text":"","category":"section"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"FractionalSystems.jl is evolved from FOMCON and FOTF, which are Matlab toolboxs used for fractional order modeling and computing in Matlab. In the future, we plan to integrate all the current fractional order modeling toolboxs, such as Ninteger toolbox, CRONE toolbox and with the help of Julia, build a performant and feature rich toolbox.","category":"page"},{"location":"","page":"FractionalSystems.jl","title":"FractionalSystems.jl","text":"info: WIP\nFractionalSystems.jl is under heavy construction, some API or docs might change a lot.","category":"page"}]
}
