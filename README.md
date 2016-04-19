## Minescooper
This is a minesweeper clone with a large degree of flexibility. In addition to normal square cells, you may also choose many other cell shapes. This app was inspired by Bojan Urosevic's Windows game called "Professional Minesweeper".

The framework for this application is based on Tommy Marshall's easeljs-box2d-example:
https://github.com/tommymarshall/easeljs-box2d-example.git

### Installation

#### Install Gulp
```bash
$ npm install -g gulp
```

#### Install Dependencies
```bash
$ git clone git@github.com:tgrindinger/minescooper.git
$ cd minescooper
$ npm install
$ gulp
```

### Development
While running `gulp` from the command line, any images, coffeescript, or .html files that are saved will automatically be optimized, compiled or copied and added to the `build` directory.
Relevant files for the game are all saved in `source/javascripts/` directory as .coffee files.
