subroutine Bethe_Salpeter_A_matrix(nBas,nC,nO,nV,nR,nS,ERI,Omega,rho,A_lr)

! Compute the extra term for Bethe-Salpeter equation for linear response 

  implicit none
  include 'parameters.h'

! Input variables

  integer,intent(in)            :: nBas,nC,nO,nV,nR,nS
  double precision,intent(in)   :: ERI(nBas,nBas,nBas,nBas) 
  double precision,intent(in)   :: Omega(nS),rho(nBas,nBas,nS)
  
! Local variables

  double precision              :: chi
  integer                       :: i,j,a,b,ia,jb,kc

! Output variables

  double precision,intent(out)  :: A_lr(nS,nS)

  ia = 0
  do i=nC+1,nO
    do a=nO+1,nBas-nR
      ia = ia + 1
      jb = 0
      do j=nC+1,nO
        do b=nO+1,nBas-nR
          jb = jb + 1
 
          chi = 0d0
          do kc=1,nS
            chi = chi + rho(i,j,kc)*rho(a,b,kc)/Omega(kc)
          enddo

          A_lr(ia,jb) = A_lr(ia,jb) - ERI(i,a,j,b) + 4d0*chi
 
        enddo
      enddo
    enddo
  enddo

end subroutine Bethe_Salpeter_A_matrix
