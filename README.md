

## PlanetNICFI

<br>

The **PlanetNICFI** R package includes functions to download and process the [NICFI](https://www.nicfi.no/) (**Norway's International Climate and Forest Initiative**) Planet Satellite Imagery utilizing the [Planet Mosaics API](https://developers.planet.com/docs/basemaps/reference/#tag/Basemaps-and-Mosaics)

<br>

#### **System Requirements**:

<br>

##### **GDAL**

Due to the fact that *PlanetNICFI* uses the [sf](https://github.com/r-spatial/sf) and [gdalUtils](https://CRAN.R-project.org/package=gdalUtils) R packages internally, **it is required** that the user has already [GDAL](https://gdal.org/) installed and configured. The [README.md file of the **'sf'**](https://github.com/r-spatial/sf#installing) package includes instructions on how to install and configure GDAL on all operating systems.

<br>

##### **aria2c**

The [aria2c](https://aria2.github.io/) software is required for the paralleled download of the data, which has to be installed first in the Operating System:

On **Ubuntu** this can be done using:

```R
sudo apt-get install aria2

```

<br>

On **Macintosh** use,

```R
brew install aria2

```

<br>

and on **Windows 10** based on a [web-tutorial](https://www.tutorialexample.com/install-aria2-on-win10-to-download-files-a-beginner-guide/):

* first navigate to the [Github repository of aria2c](https://github.com/aria2/aria2/releases/tag/release-1.35.0)
* then download the **aria2-1.35.0-win-64bit-build1.zip** (where **1.35.0** corresponds to the current version as of **June 2021** - this might change in the future)
* unzip the downloaded file 
* create a folder named as **aria2** in **C:\\**
* copy the **aria2c.exe** file to **C:\\aria2**
* add the **C:\\aria2** to the windows system path by updating the environment variables
* finally open the window command prompt, enter **aria2c** and the output message should show the aria2c options

<br>

To install the package from CRAN use, 

```R
install.packages("PlanetNICFI")

```
<br>

and to download the latest version of the package from Github,

```R
remotes::install_github('mlampros/PlanetNICFI')

```

<br>

### Attribution

Please read the **COPYRIGHTS** file of the **PlanetNICFI** R package especially the section **'OBLIGATIONS AND RESTRICTIONS'**

<br>

### Citation:

If you use the **PlanetNICFI** R package in your paper or research please cite:

<br>

```R
@Manual{,
  title = {{PlanetNICFI}: Processing of the 'Planet NICFI' Satellite Imagery using R},
  author = {Lampros Mouselimis},
  year = {2021},
  note = {R package version 1.0.0 using Imagery 2021 Planet Labs Inc. All use subject to the Participant License Agreement},
  url = {https://CRAN.R-project.org/package=PlanetNICFI},
}
```

<br>
