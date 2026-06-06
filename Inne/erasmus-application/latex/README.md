# Rental letter to Micke

LaTeX source for the room application letter.

## Fill in
- Open `main.tex` and edit the block marked **EDIT YOUR CONTACT DATA HERE**
  (phone, LinkedIn — or delete the `\faLinkedin ...` line if you don't want it).
- Drop up to three images into `photos/` named `photo1.jpg`, `photo2.jpg`,
  `photo3.jpg` and tweak the captions. Missing photos render as a placeholder
  box, so it compiles either way.

## Build
```powershell
pdflatex main.tex
```
Needs a TeX distribution (MiKTeX / TeX Live) with the `fontawesome5` and
`tcolorbox` packages. On a first MiKTeX run it will offer to install them.

Or just upload `main.tex` + the `photos/` folder to Overleaf.
