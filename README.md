# nice-matlab-figures
Functions for the generation of good-looking plots and figures in Matlab.

## Motivation
This repository was created to make publicly available a couple of functions that I developed to automatize graphic formatting of Matlab figures. A great inspiration was taken from the post [*Making Pretty Graphs* by Loren Shure](https://blogs.mathworks.com/loren/2007/12/11/making-pretty-graphs/).

## Installation
1. Download the package to a local folder (e.g. ~/nice-matlab-figures/) by running: 
```console
git clone https://github.com/fmamitrotta/nice-matlab-figures.git
```
2. Run Matlab and add the folder (~/nice-matlab-figures/) to your Matlab path.

3. Make your plots and improve their appearance. Enjoy!

## Usage
Use the `makePlotNicer` function on your plot to improve its appearance. You can also set nice labels, legend and much more using the appropriate input parameters. Remember to use LaTeX syntax for all text features, as the function interprets characters using LaTeX markup by default. Use the `saveNiceFigure` to save your Matlab figures with a good-looking appearance in both .fig and .eps format. In the future it will be possible to choose among different formats (or you can modify the function yourself according to your need).

## Contributing
Please don't hesistate to throw feedback and suggestions. Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License
[GPL-3.0](https://choosealicense.com/licenses/gpl-3.0/)
