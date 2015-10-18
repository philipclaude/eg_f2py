      SUBROUTINE SOLVEM(S,SONIC)

      USE IN_VAR
      USE OUT_VAR

      IMPLICIT NONE

      REAL :: ML,MR,MH,fL,fH,S
      INTEGER :: SONIC
      REAL :: ISENTROPICREL

      IF (SONIC==0) THEN
      ML = 0 
      MR = 1
      fL = ISENTROPICREL(GAMM,ML) -S
      
      DO WHILE (ABS(MR-ML) > MTOL)
        MH = 0.5*(ML+MR) 
        fH = ISENTROPICREL(GAMM,MH) -S 
      
        IF (fH*fL < 0) THEN
          MR = MH
        ELSE
          IF (fH*fL == 0) THEN
            M = MH
            RETURN
          END IF
          ML = MH
        END IF
         fL = ISENTROPICREL(GAMM,ML) -S
      END DO
      M = MH
      RETURN

      ELSE IF (SONIC == 1) THEN 
        ML = 1     
        MR = 10
        fL = ISENTROPICREL(GAMM,ML) -S
      
      DO WHILE (ABS(MR-ML) > MTOL)
        MH = 0.5*(ML+MR)
        fH = ISENTROPICREL(GAMM,MH) -S 
      
      IF (fH*fL < 0) THEN
        MR = MH
      ELSE
        IF (fH*fL == 0) THEN
          M = MH
          RETURN
        END IF
        ML = MH
      END IF
      fL = ISENTROPICREL(GAMM,ML) -S
      END DO
      M = MH
      
      RETURN
      
      END IF

      END SUBROUTINE SOLVEM

      REAL FUNCTION ISENTROPICREL( GAMM , M )
        REAL:: GAMM,M
        REAL:: S
        REAL:: R
        R = .5*(GAMM +1)/(GAMM -1)
        S = ( (2 +(GAMM-1)*M*M)/(GAMM+1) )**R
        ISENTROPICREL = S/M
        RETURN
      END FUNCTION
