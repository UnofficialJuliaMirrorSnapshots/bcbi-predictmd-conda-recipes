<!-- Beginning of file -->

# predictmd-conda-recipes: Conda recipes for installing the binary requirements for plotting in PredictMD
# Main repository: [bcbi/PredictMD.jl](https://github.com/bcbi/PredictMD.jl)
# Website: [https://www.predictmd.net](https://www.predictmd.net)

<img src="https://www.repostatus.org/badges/latest/active.svg" alt="Project Status: Active – The project has reached a stable, usable state and is being actively developed." />

This repository contains Conda recipes for building the binary dependencies that are required for enabling the plotting functionality in [PredictMD](https://www.predictmd.net). These binary dependencies are not required for using most of the functionality in PredictMD. They are only required for plotting.

These recipes are only intended for use inside the `mhowison/conda-build:v2` Docker image, and therefore they may not work in other environments.

Issues related to this repository should be submitted to the main PredictMD issue tracker: [https://github.com/bcbi/PredictMD.jl/issues](https://github.com/bcbi/PredictMD.jl/issues)

### Table of Contents
- [CI/CD](#cicd)
- [Recipes](#recipes)
- [Usage](#usage)

## CI/CD

<table>
    <thead>
        <tr>
            <th></th>
            <th>master</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Travis CI</td>
            <td><a href="https://travis-ci.org/bcbi/predictmd-conda-recipes/branches"><img alt="Travis build status (master)" title="Travis build status (master)" src="https://travis-ci.org/bcbi/predictmd-conda-recipes.svg?branch=master"></a></td>
        </tr>
    </tbody>
</table>

## Recipes

<table>
    <thead>
        <tr>
            <th>dependency</th>
            <th>recipe name</th>
            <th>version</th>
            <th>platform</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>ImageMagick</td>
            <td>predictmd-imagemagick</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-imagemagick"><img alt="predictmd-imagemagick version" title="predictmd-imagemagick version" src="https://anaconda.org/dilumaluthge/predictmd-imagemagick/badges/version.svg" /></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-imagemagick"><img alt="predictmd-imagemagick platforms" title="predictmd-imagemagick platforms" src="https://anaconda.org/dilumaluthge/predictmd-imagemagick/badges/platforms.svg" /></a></td>
        </tr>
            <td>pdf2svg</td>
            <td>predictmd-pdf2svg</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-pdf2svg"><img alt="predictmd-pdf2svg version" title="predictmd-pdf2svg version" src="https://anaconda.org/dilumaluthge/predictmd-pdf2svg/badges/version.svg" /></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-pdf2svg"><img alt="predictmd-pdf2svg platforms" title="predictmd-pdf2svg platforms" src="https://anaconda.org/dilumaluthge/predictmd-pdf2svg/badges/platforms.svg" /></a></td>
        <tr>
            <td>TeX Live</td>
            <td>predictmd-texlive</td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-texlive"><img alt="predictmd-texlive version" title="predictmd-texlive version" src="https://anaconda.org/dilumaluthge/predictmd-texlive/badges/version.svg" /></a></td>
            <td><a href="https://anaconda.org/dilumaluthge/predictmd-texlive"><img alt="predictmd-texlive platforms" title="predictmd-texlive platforms" src="https://anaconda.org/dilumaluthge/predictmd-texlive/badges/platforms.svg" /></a></td>
        </tr>
    </tbody>
</table>

## Usage

**Step 1:** Make sure that the Docker daemon is running.

**Step 2:** Open bash and run the following command.
```bash
docker run --name BUILD_PREDICTMD_DEPS_CONDA -it mhowison/conda-build:v2
```

**Step 3:** Now you are inside the Docker container. Run the following commands inside the container:
```bash
cd ~
conda install -y anaconda-client
wget --output-document=predictmd-conda-recipes-master.zip https://github.com/bcbi/predictmd-conda-recipes/archive/master.zip
unzip predictmd-conda-recipes-master.zip
rm predictmd-conda-recipes-master.zip
cd predictmd-conda-recipes-master
```

**Step 4 (optional, but recommended):** You can tell conda-build to automatically upload successful builds to the Anaconda.org cloud by doing the following:

* First, make sure that you have created a free Anaconda.org account.

* Second, run the following command and enter your Anaconda.org username and password when prompted:
```bash
anaconda login
```

* Third, run the following command, which tells conda-build to automatically upload after a successful build:
```bash
conda config --set anaconda_upload yes
```

**Step 5:** Now you are ready to build the packages. This step will take the longest. Run the following command to build all of the recipes:
```bash
conda build predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 6:** After the packages have successfully built, make sure that they install without any errors:
```bash
conda install -y --use-local predictmd-imagemagick predictmd-pdf2svg predictmd-texlive
```

**Step 7:** Download and install Julia. You want the **64-bit version** of the **Generic Linux Binaries for x86**, available here: [https://julialang.org/downloads/](https://julialang.org/downloads/)
```bash
cd ~
wget --output-document=julia.tar.gz https://julialang-s3.julialang.org/bin/linux/x64/0.6/julia-0.6.3-linux-x86_64.tar.gz
tar xzf julia.tar.gz
rm -rf julia.tar.gz
mv julia-* julia
```

**Step 8:** Install PredictMD.
```bash
cd ~
export CONDA_PREFIX=`conda info --base || conda info --root`
export MAGICK_HOME=$CONDA_PREFIX/lib
~/julia/bin/julia -e 'Pkg.init()'
~/julia/bin/julia -e 'Pkg.update()'
~/julia/bin/julia -e 'Pkg.clone("https://github.com/bcbi/PredictMD.jl")'
~/julia/bin/julia -e 'Pkg.update()'
```

**Step 9:** Test the `master` (stable) version of PredictMD:
```bash
export PREDICTMD_FORCE_TEST_PLOTS=true
~/julia/bin/julia -e 'Pkg.checkout("PredictMD", "master"); Pkg.test("PredictMD");'
```

If you see the message "INFO: PredictMD tests passed", then the tests have passed on the `master` branch. If you see a different message, then the tests did not pass.

**Step 10:** Test the `develop` (latest) version of PredictMD:
```bash
export PREDICTMD_TEST_GROUP=test-plots
~/julia/bin/julia -e 'Pkg.checkout("PredictMD", "develop"); Pkg.test("PredictMD");'
```

If you see the message "INFO: PredictMD tests passed", then the tests have passed on the `develop` branch. If you see a different message, then the tests did not pass.

**Step 11:** You can exit the Docker container at any time by typing `exit` and pressing enter.

**Step 12:** To return to the container at a later time, run the following command in bash:
```bash
docker start -a -i BUILD_PREDICTMD_DEPS_CONDA
```

**Step 13:** When you are ready to delete the container, first make sure that you have exited the container. Then, run the following command in bash:
```bash
docker container rm BUILD_PREDICTMD_DEPS_CONDA
```

<!-- End of file -->
