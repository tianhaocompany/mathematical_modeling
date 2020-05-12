module comblk
 implicit none
 integer, parameter :: nt=601, nnn=100000, no=601
 real, parameter :: g=3.986005e14, dt=0.2
 integer, dimension(nt), save :: iobs
 real, dimension(nt), save :: obsx, obsy, obsz
 real, dimension(nt), save :: x, y, z, r, u, v, w, vx, vy, vz
 real, dimension(nt,2), save :: aa, bb, cc
 real, dimension(nnn), save :: costfunction, cf
 real, dimension(nt,3), save :: grad
 real, save :: stepL, tmp, grad0
end module comblk


program trajectory
 ! 2012-9-22
 ! 假设：
 ! m(t)=m0*f(t),g(t)=f'(t)/f(t)
 ! vr(t)=v0*[a(t) b(t) c(t)]
 use comblk
 integer :: i, n


 iobs=0
 do i=1,no
    iobs(i)=1
 end do


 open(1, file='traj_fxq.dat', action='read')
 do i=1,no
    read(1, *), obsx(i), obsy(i), obsz(i)
 end do
 close(1)

 ! 步长因子
 stepL=10000.

 ! 初始猜测？
 aa(:,2)=10.
 bb(:,2)=10.
 cc(:,2)=10.

 ! 输出文件
 open(70, file='cost.dat', action='write')
 open(80, file='grad.dat', action='write')
! open(91, file='aa_t.dat', action='write')
! open(92, file='bb_t.dat', action='write')
! open(93, file='cc_t.dat', action='write')

 do n=1,nnn
    aa(:,1)=aa(:,2)
	bb(:,1)=bb(:,2)
	cc(:,1)=cc(:,2)
	x(1:2)=obsx(1:2)
	y(1:2)=obsy(1:2)
	z(1:2)=obsz(1:2)
	r(1)=sqrt(x(1)**2+y(1)**2+z(1)**2)
	r(2)=sqrt(x(2)**2+y(2)**2+z(2)**2)

	! 正向迭代过程
	call forward

	! 输出正向模拟结果
	call output_forward

	! 计算代价函数
	call costF(n)
	write(70, '(i5, f10.4)'), n, cf(n)
	print*, n, cf(n)

	u(nt)=0.
	u(nt-1)=0.
	v(nt)=0.
	v(nt-1)=0.
	w(nt)=0.
	w(nt-1)=0.
	! 计算反向过程
	call adjoint

	grad=0.
	! 计算梯度
	call gradient

	if(n==1)then
	  grad0=0.
	  do i=1,nt
	     grad0=grad0+sqrt(grad(i,1)**2+grad(i,2)**2+grad(i,3)**2)
	  end do
	end if
	grad=grad/grad0

	do i=1,nt
	   aa(i,2)=aa(i,1)+grad(i,1)*stepL
	   bb(i,2)=bb(i,1)+grad(i,2)*stepL
	   cc(i,2)=cc(i,1)+grad(i,3)*stepL
	end do
!	write(91, '(<nt>f10.4)'), aa(:,2)
!	write(92, '(<nt>f10.4)'), bb(:,2)
!	write(93, '(<nt>f10.4)'), cc(:,2)

 end do

 close(70)
 close(80)
! close(91)
! close(92)
! close(93)

 call forward
 call velocity
 call output_velocity
 
 open(100, file='traj_model.dat', action='write')
 do i=1,nt
!    if(iobs(i)==1)then
	  write(100, '(3f20.5)'), x(i), y(i), z(i)
!	end if
 end do
 close(100)

 open(100, file='para_model.dat', action='write')
 write(100, '(<nt>f20.5)'), aa(:,2)
 write(100, '(<nt>f20.5)'), bb(:,2)
 write(100, '(<nt>f20.5)'), cc(:,2)
 close(100)

end program trajectory

! 正向迭代过程
subroutine forward
 use comblk
 implicit none
 integer:: i

 do i=3,nt
    x(i)=2*x(i-1)-x(i-2)-dt**2*(g/(r(i-1)**3)*x(i-1)-aa(i,1))
	y(i)=2*y(i-1)-y(i-2)-dt**2*(g/(r(i-1)**3)*y(i-1)-bb(i,1))
	z(i)=2*z(i-1)-z(i-2)-dt**2*(g/(r(i-1)**3)*z(i-1)-cc(i,1))
	r(i)=sqrt(x(i)**2+y(i)**2+z(i)**2)
 end do

end subroutine forward

! 输出正向结果
subroutine output_forward
 use comblk
 implicit none
 integer :: i

 open(111, file='xyz_forward.dat', action='write')
 do i=1,nt
    write(111, '(3e15.7)'), x(i), y(i), z(i)
 end do
 close(111)

end subroutine output_forward

! 计算代价函数
subroutine costF(n)
 use comblk
 implicit none
 integer, intent(in) :: n
 integer :: i

 costfunction(n)=0
 do i=1,nt
    if(iobs(i)==1)then
	  costfunction(n)=costfunction(n)+(x(i)-obsx(i))**2+(y(i)-obsy(i))**2+(z(i)-obsz(i))**2
	end if
 end do
 cf(n)=costfunction(n)/costfunction(1)

end subroutine



! 计算反向过程
subroutine adjoint
 use comblk
 implicit none
 integer :: i

 do i=nt-2,1,-1
    u(i)=2*u(i+1)-u(i+2)-dt**2*(g*u(i+1)*(y(i+1)**2+z(i+1)**2-2*x(i+1)**2)/r(i+1)**5+iobs(i+1)*(x(i+1)-obsx(i+1))-g*3*x(i+1)*(y(i+1)*v(i+1)+z(i+1)*w(i+1))/r(i+1)**5)
	v(i)=2*v(i+1)-v(i+2)-dt**2*(g*v(i+1)*(x(i+1)**2+z(i+1)**2-2*y(i+1)**2)/r(i+1)**5+iobs(i+1)*(y(i+1)-obsy(i+1))-g*3*y(i+1)*(x(i+1)*u(i+1)+z(i+1)*w(i+1))/r(i+1)**5)
	w(i)=2*w(i+1)-w(i+2)-dt**2*(g*w(i+1)*(x(i+1)**2+y(i+1)**2-2*z(i+1)**2)/r(i+1)**5+iobs(i+1)*(z(i+1)-obsz(i+1))-g*3*w(i+1)*(x(i+1)*u(i+1)+y(i+1)*v(i+1))/r(i+1)**5)
 end do

end subroutine adjoint

subroutine gradient
 use comblk
 implicit none
 integer :: i
 
 do i=1,nt
    grad(i,1)=u(i)
	grad(i,2)=v(i)
	grad(i,3)=w(i)
 end do

end subroutine gradient

subroutine velocity
 use comblk
 implicit none
 integer :: i

 do i=1,nt-1
    vx(i)=(x(i+1)-x(i))/dt
	vy(i)=(y(i+1)-y(i))/dt
	vz(i)=(z(i+1)-z(i))/dt
 end do

end subroutine velocity

subroutine output_velocity
 use comblk
 implicit none
 integer :: i

 open(111, file='uvw_forward.dat', action='write')
 do i=1,nt-1
    write(111, '(3e15.7)'), vx(i), vy(i), vz(i)
 end do
 close(111)

end subroutine output_velocity