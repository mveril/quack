subroutine AOtoMO_integral_transform(nBas,c,ERI_AO_basis,ERI_MO_basis)

! AO to MO transformation of two-electron integrals
! Semi-direct O(N^5) algorithm

  implicit none

! Input variables

  integer,intent(in)            :: nBas
  double precision,intent(in)   :: ERI_AO_basis(nBas,nBas,nBas,nBas),c(nBas,nBas)

! Local variables

  double precision,allocatable  :: scr(:,:,:,:)
  integer                       :: mu,nu,la,si,i,j,k,l

! Output variables

  double precision,intent(out)  :: ERI_MO_basis(nBas,nBas,nBas,nBas)

! Memory allocation
  allocate(scr(nBas,nBas,nBas,nBas))

  scr = 0d0
  do l=1,nBas
    do si=1,nBas
      do la=1,nBas
        do nu=1,nBas
          do mu=1,nBas
            scr(mu,nu,la,l) = scr(mu,nu,la,l) + ERI_AO_basis(mu,nu,la,si)*c(si,l)
          enddo
        enddo
      enddo
    enddo
  enddo
 
  do l=1,nBas
    do la=1,nBas
      do nu=1,nBas
        do i=1,nBas
          ERI_MO_basis(i,nu,la,l) = 0d0
          do mu=1,nBas
            ERI_MO_basis(i,nu,la,l) = ERI_MO_basis(i,nu,la,l) + c(mu,i)*scr(mu,nu,la,l)
          enddo
        enddo
      enddo
    enddo
  enddo

  scr = 0d0
  do l=1,nBas 
    do k=1,nBas
      do la=1,nBas
        do nu=1,nBas
          do i=1,nBas
            scr(i,nu,k,l) = scr(i,nu,k,l) + ERI_MO_basis(i,nu,la,l)*c(la,k)
          enddo
        enddo
      enddo
    enddo
  enddo

  do l=1,nBas
    do k=1,nBas
      do j=1,nBas
        do i=1,nBas
          ERI_MO_basis(i,j,k,l) = 0d0
          do nu=1,nBas
            ERI_MO_basis(i,j,k,l) = ERI_MO_basis(i,j,k,l) + c(nu,j)*scr(i,nu,k,l)
          enddo
        enddo
      enddo
    enddo
  enddo

end subroutine AOtoMO_integral_transform
