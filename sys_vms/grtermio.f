C*********
      SUBROUTINE GRCTER(ICHAN)
      INTEGER   ICHAN
C---
C Close a previously opened channel.
C---
C ICHAN     I    The channel number to be closed
C---
      CALL SYS$DASSGN(%val(ICHAN))
      RETURN
      END
      INTEGER FUNCTION GROTER(CDEV, LDEV)
      CHARACTER CDEV*(*)
      INTEGER   LDEV
C---
C Open a channel to the device specified by CDEV.
C---
C CDEV      I    The name of the device to be opened
C LDEV      I    Number of valid characters in device
C GROTER      O  The open channel number (-1 indicates an error)
C---
      INTEGER ICHAN
C---
      CALL SYS$ASSIGN(CDEV(:LDEV),ICHAN,,)
      GROTER=ICHAN
      RETURN
      END
      SUBROUTINE GRPTER(ICHAN, PROMPT, LPROM, CBUF, LBUF)
      CHARACTER PROMPT*(*), CBUF*(*)
      INTEGER   ICHAN, LPROM, LBUF
C---
C revised 3-Jun-1997: use NOFILTR to pass DEL etc.
C---
      INCLUDE '($IODEF)'
      INTEGER   IREAD
      PARAMETER (IREAD= IO$M_PURGE + IO$M_NOFORMAT + IO$M_NOFILTR +
     :           IO$M_NOECHO + IO$M_TIMED + IO$_READPROMPT)
      INTEGER   ITIME
      PARAMETER (ITIME=60)
      INTEGER IQUAD0(2)
      DATA IQUAD0/0,0/
C---
      CALL SYS$QIOW(,%val(ICHAN),%val(IREAD),,,,
     :     %ref(CBUF),%val(LBUF),%val(ITIME),IQUAD0,
     :     %ref(PROMPT),%val(LPROM))
      RETURN
      END
C*********
      SUBROUTINE GRWTER(ICHAN, CBUF, LBUF)
      CHARACTER CBUF*(*)
      INTEGER   ICHAN, LBUF
C---
C Write LBUF bytes from CBUF to the channel ICHAN.  Data is written
C with no formatting.
C---
C ICHAN     I    The channel number
C CBUF      I    Character array of data to be written
C LBUF      I/O  The number of bytes to write, set to zero on return
C---
      INCLUDE '($IODEF)'
C---
      CALL SYS$QIOW(,%val(ICHAN),
     :   %val(IO$_WRITEVBLK.OR.IO$M_NOFORMAT),,,,
     :      %ref(CBUF),%val(LBUF),,,,)
      LBUF=0
      RETURN
      END
C*********
      SUBROUTINE GRRTER(ICHAN, CBUF, LBUF)
      CHARACTER CBUF*(*)
      INTEGER   ICHAN, LBUF
C---
C Read LBUF bytes from device assigned to channel ICHAN to CBUF.
C Previous unread data is purged.  Data is read without format
C or echo.
C---
C ICHAN     I    The channel number
C CBUF        O  Character array of data read
C LBUF      I/O  The number of bytes to write, set to zero on return
C---
      INCLUDE '($IODEF)'
      INTEGER   IREAD
      PARAMETER (IREAD= IO$_TTYREADALL + IO$M_PURGE + IO$M_NOFORMAT +
     :           IO$M_NOECHO + IO$M_TIMED)
      INTEGER   ITIME
      PARAMETER (ITIME=60)
      INTEGER IQUAD0(2)
      DATA IQUAD0/0,0/
C---
      CALL SYS$QIOW(,%val(ICHAN),%val(IREAD),,,,
     :      %ref(CBUF),%val(LBUF),%val(ITIME),IQUAD0,,)
      RETURN
      END
