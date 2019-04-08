set -o verbose
set -o errexit

#wget --output-document=install-tl-unx.tar.gz http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/install-tl-unx.tar.gz
cp $RECIPE_DIR/downloads/install-tl-unx.tar.gz .
tar -vzxf install-tl-unx.tar.gz
rm -f install-tl-unx.tar.gz
mv install-tl-* install-tl

rm -f predictmd-texlive.profile
printf "selected_scheme scheme-small\n" >> predictmd-texlive.profile
printf "TEXDIR $PREFIX/texlive/2017\n" >> predictmd-texlive.profile
printf "TEXMFCONFIG ~/.texlive2017/texmf-config\n" >> predictmd-texlive.profile
printf "TEXMFHOME ~/texmf\n" >> predictmd-texlive.profile
printf "TEXMFLOCAL $PREFIX/texlive/texmf-local\n" >> predictmd-texlive.profile
printf "TEXMFSYSCONFIG $PREFIX/texlive/2017/texmf-config\n" >> predictmd-texlive.profile
printf "TEXMFSYSVAR $PREFIX/texlive/2017/texmf-var\n" >> predictmd-texlive.profile
printf "TEXMFVAR ~/.texlive2017/texmf-var\n" >> predictmd-texlive.profile
printf "binary_x86_64-linux 1\n" >> predictmd-texlive.profile
printf "instopt_adjustpath 1\n" >> predictmd-texlive.profile
printf "instopt_adjustrepo 1\n" >> predictmd-texlive.profile
printf "instopt_letter 1\n" >> predictmd-texlive.profile
printf "instopt_portable 0\n" >> predictmd-texlive.profile
printf "instopt_write18_restricted 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_autobackup 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_backupdir tlpkg/backups\n" >> predictmd-texlive.profile
printf "tlpdbopt_create_formats 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_desktop_integration 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_file_assocs 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_generate_updmap 0\n" >> predictmd-texlive.profile
printf "tlpdbopt_install_docfiles 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_install_srcfiles 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_post_code 1\n" >> predictmd-texlive.profile
printf "tlpdbopt_sys_bin $PREFIX/bin\n" >> predictmd-texlive.profile
printf "tlpdbopt_sys_info ~/texlive-info\n" >> predictmd-texlive.profile
printf "tlpdbopt_sys_man $PREFIX/man\n" >> predictmd-texlive.profile
printf "tlpdbopt_w32_multi_user 1\n" >> predictmd-texlive.profile

cd install-tl
./install-tl --profile=../predictmd-texlive.profile -repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/tlnet-final/
cd ..
rm -rf install-tl

tlmgr option repository http://ftp.math.utah.edu/pub/tex/historic/systems/texlive/2017/tlnet-final/
tlmgr update --self
tlmgr update --all
tlmgr install lm luatex85 pgfplots standalone

