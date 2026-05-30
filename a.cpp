#include<bits/stdc++.h>
using namespace std;
#define N 1<<20
using u64=unsigned long long;
#define MST(x) memset(x,0,sizeof(x))
//string s="test";u64 st=1;
//u64 qp(u64 a,u64 b,u64 m){u64 ans=1ull;a%=m;for(;b;b>>=1,a=a*a%m)(b&1)&&(ans=ans*a%m);return ans;}
//u64 sum(u64 a,u64 c,u64 m,u64 x){u64 ans=0,cur=1;a%=m;for(;x;x>>=1,cur=cur*(1+a)%m,a=a*a%m)(x&1)&&(ans=(ans*a%m+cur%m));return ans;}
//u64 rng(u64 a,u64 c,u64 m,u64 x0,int x){if(!x)return x0;u64 ai=qp(a,x,m),gs=sum(a,c,m,x);return (ai*x0+c*gs)%m;}
//string ec(u64 a,u64 c,u64 m,u64 sd){int n=s.size();string ans;ans.resize(n);int x;for(x=0;x<n;x++){u64 ks=rng(a,c,m,sd,x);ans[x]=s[x]^(char)(ks&0xff);}return ans;}
using u32=uint32_t;
u64 st=0;
u32 r32(u32 v,u32 r){return (v>>r)|(v<<32-r);}
void f(u32 s){st=s|1;}
u32 pcg(){u64 la=st;st=st*747796405u+2891336453u;u32 u=la>>(29-(st>>61));return u;}
u32 pcg32(){u64 la=st;st=st*747796405u+2891336453u;u32 u=(la^(la>>22u))>>(22u+(la>>61u));return u;}
u32 pcg1(){u64 la=st;st=st*747796405u+2891336453u;u32 u=r32(st^(st>>18)>>27,st>>59);return u;}
int main(){f(100);int x;for(x=1;x<=10;x++)pcg1();for(x=1;x<=10;x++)cout<<pcg1()<<endl;return 0;}

template<typename T>
vec3<T,V>sp(const vec3<T,V>&v){
    sampler<T>s;
    T u=s.get1d(),v=s.get1d();T phi=2.0*3.1415926535*u;
    T r=sqrt(v);assert(!isnan(r));T x=cos(phi)*r,z=sin(phi)*r,y=sqrt(max(0.0,1.0-v));vec3<T,V>u1;
    if(abs(n.x)>T(0.1))u1=nor(cs(vec3<T,V>(0,1.0,0),n));
    else u1=nor(cs(vec3<T,V>(1.0,0,0),n));
    vec3<T,V>v1=cs(n,u1);return x*u1+y*n+z*v1;
}
template<typename T>
vec3<T,P>sun(5,5,5);
template<typename T>
vec3<T,P>p1(6,5,2);
template<typename T>
vec3<T,P>p2(3,7,4);
template<typename T>
Spectrum<T>sc(10,10,10);
template<typename T>
vec3<T,V>e1=p1<T>-sun<T>;
template<typename T>
vec3<T,V>e2=p2<T>-sun<T>;
template<typename T>
vec3<T,V>area(){
    sampler<T>s;
    T u=s.get1d(),v=s.get1d();vec3<T,V>rd=u*e1<T>+v*e2<T>;
    vec3<T,P>pt=sun<T>+vec3<T,P>(rd.x,rd.y,rd.z);
    vec3<T,V>dir=pt-p;vec3<T,V>n1=nor(cs(e1<T>,e2<T>));
    T s=len(cs(e1<T>,e2<T>));T dis=max(len(dir),eps);return nor(dir);
}
