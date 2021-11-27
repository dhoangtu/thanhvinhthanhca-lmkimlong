
@ECHO ON

set GEN=".\pdf-generated"
set QPDF="C:\data\91.Study\01.Software\qpdf-10.1.0\bin"

%QPDF%\qpdf --empty --pages C:\data\91.Study\08.github\tuyentaphopca-lmkimlong\nhac\*.pdf -- nhac.pdf

pdflatex so-trang-chan-le.tex

%QPDF%\qpdf --empty --pages bia-truoc.pdf blank-a4.pdf so-trang-chan-le.pdf blank-a4.pdf bia-sau-trong.pdf -- tuyentaphopca-lmkimlong.pdf

del /s /f /q %GEN% nhac.pdf *.aux *.log so-trang-chan-le.pdf
