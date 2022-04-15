using FractionalDiffEq

function LE(ne,ext_fcn,t_start,h_norm,t_end,x_start,h,q,out);

    x=zeros(ne*(ne+1))
    x0=copy(x)
    c=zeros(ne,1)
    gsc=copy(c)
    zn=copy(c)
    n_it = round(Int, (t_end-t_start)/h_norm)
        x[1:ne]=x_start
        i=1;
        while i<=ne
            x[(ne+1)*i]=1.0
            i=i+1
        end
        t=t_start
    it=1
    while it<=n_it
            LE=zeros(ne,1)
            prob = FODESystem(ext_fcn, 0.999*ones(12), x)
            Y = solve(prob, h, t+h_norm, GLWithMemory())
            #Y = fde12(q,ext_fcn,t,t+h_norm,x,h)
            t=t+h_norm

            x=Y[size(Y, 1), :]
            i=1
            while i<=ne
                j=1
                while j<=ne
                    x0[ne*i+j]=x[ne*j+i]
                    j=j+1
                end
                i += 1
            end
            zn[1]=0.0
            j=1
            while j<=ne
                zn[1]=zn[1]+x0[ne*j+1]^2
                j=j+1
            end;
            zn[1]=sqrt(zn[1])
            j=1
            while j<=ne
                x0[ne*j+1]=x0[ne*j+1]/zn[1]
                j=j+1
            end
            j=2
            while j<=ne
                k=1
                while k<=j-1
                    gsc[k]=0.0
                    l=1
                    while l<=ne
                        gsc[k]=gsc[k]+x0[ne*l+j]*x0[ne*l+k]
                        l=l+1
                    end
                    k=k+1
                end
                k=1
                while k<=ne
                    l=1
                    while l<=j-1
                        x0[ne*k+j]=x0[ne*k+j]-gsc[l]*x0[ne*k+l]
                        l=l+1
                    end
                    k=k+1
                end
                zn[j]=0.0
                k=1
                while k<=ne
                    zn[j]=zn[j]+x0[ne*k+j]^2
                    k=k+1
                end
                zn[j]=sqrt(zn[j])
                k=1
                while k<=ne
                    x0[ne*k+j]=x0[ne*k+j]/zn[j]
                    k=k+1
                end
                j=j+1
            end

            k=1
            while k<=ne
                c[k]=c[k]+log(zn[k])
                k=k+1
            end

            k=1
            while k<=ne
                LE[k]=c[k]/(t-t_start)
                k=k+1
            end

            if mod(it,out)==0
            println(LE)
            end
            i=1
            while i<=ne
                j=1
                while j<=ne
                    x[ne*j+i]=x0[ne*i+j]
                    j=j+1
                end
                i=i+1
            end;
            x=transpose(x)
            it=it+1
        end
        return x
end
#=
function testf!(du, u, p, t)
    du[1]=u[2]*(u[3]-1+u[1]*u[1])+0.1*u[1]
    du[2]=u[1]*(3*u[3]+1-u[1]*u[1])+0.1*u[2]
    du[3]=-2*u[3]*(0.98+u[1]*u[2])
    du[4]=(2*u[1]*u[2]+0.1)*u[4] + (u[1]*u[1]+u[3]-1)*u[5] + u[2]*u[6]
    du[5]=(2*u[1]*u[2]+0.1)*u[7] + (u[1]*u[1]+u[3]-1)*u[8] + u[2]*u[9]
    du[6]=(2*u[1]*u[2]+0.1)*u[10] + (u[1]*u[1]+u[3]-1)*u[11] + u[2]*u[12]
    du[7]=(-3*u[1]*u[1]+3*u[3]+1)*u[4] + 0.1*u[5] + 3*u[1]*u[6]
    du[8]=(-3*u[1]*u[1]+3*u[3]+1)*u[7] + 0.1*u[8] + 3*u[1]*u[9]
    du[9]=(-3*u[1]*u[1]+3*u[3]+1)*u[10] + 0.1*u[11] + 3*u[1]*u[12]
    du[10]=(-2*u[2]*u[3])*u[4] + (-2*u[1]*u[3])*u[5] + (-2*(u[1]*u[2]+0.98))*u[6]
    du[11]=(-2*u[2]*u[3])*u[7] + (-2*u[1]*u[3])*u[8] + (-2*(u[1]*u[2]+0.98))*u[9]
    du[12]=(-2*u[2]*u[3])*u[10] + (-2*u[1]*u[3])*u[11] + (-2*(u[1]*u[2]+0.98))*u[12]
end

LE=test(3, testf!, 0, 0.02, 300, [0.1;0.1;0.1],0.005,[0.999, 0.999, 0.999],10)
=#