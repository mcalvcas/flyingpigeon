.. _processes:

Processes in Flyingpigeon
*************************

Flyingpigeon provides processes for climate model data analytis, climate impact studies and extrem values investigatins. 



.. _analogs:

Analog pressure pattern
-----------------------


CASTf90 first downloads fields from NCEP reanalysis (sea level pressure, slp, as default) and then searches for a given simulation period the most similar cases within a given data base period according to a given distance measure. Finally it writes the N most similar days including the calculated distances for them to an output file


.. _extract_coordinates

extract 1D Timeseries from coordinate points
--------------------------------------------

Extract Timeseries for specified coordinates from grided data

.. _extremvalues: 

Extremvalues
-------------

Calculation of retun time Values for 1D time series. 


.. _getEOBS_inCORDEXformat: 

get EOBS Data in CORDEX format
-------------------------------

converts EOBS data files into the CORDEX convetion. (variable names, attributes etc ... )

.. _fetch: 


Download Resources
------------------

Downloads resources (limited to 50GB) to the local file system of the birdhouse compute provider

.. _indices:

Climate indice
--------------

Climate indice are values to describe the state the climate system for a certain parameter. Climate indice as timeseries can be used to describe or estimate the climte change over time. 
The climate indices processes in flyingpigeon are based on the python package 'Link icclim <http://icclim.readthedocs.org/en/latest/>'.
they are subcassed to 

* indice simple: 


+--------+----------------+--------------------------------------------------------------------------------+
| Indice | Input Variable | Definition                                                                     |
+========+================+================================================================================+
| TG     |        tas     | Mean of mean temperatur                                                        |
+--------+----------------+--------------------------------------------------------------------------------+
| TX     |     tasmax     | Mean of max temperatur                                                         |
+--------+----------------+--------------------------------------------------------------------------------+
| TN     |     tasmin     | Mean of daily min temperatur                                                   |
+--------+----------------+--------------------------------------------------------------------------------+
| TXn    |     tasmax     | Min of daily min temperatur                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| TXx    |     tasmax     | Max of daily max temperatur                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| TNn    |     tasmin     | Min of daily min temperatur                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| TNx    |     tasmin     | Max of daily min temperatur                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| SU     |     tasmax     | Nr of summer days                                                              |
+--------+----------------+--------------------------------------------------------------------------------+
| CSU    |     tasmax     | Nr of consecutive summer days                                                  |
+--------+----------------+--------------------------------------------------------------------------------+
| FD     |     tasmin     | Nr of frost days                                                               |
+--------+----------------+--------------------------------------------------------------------------------+
| CFD    |     tasmin     | Nr of consecutive frost days                                                   |
+--------+----------------+--------------------------------------------------------------------------------+
| TR     |      tasmin    | Tropical nights -                                                              |
|        |                | number of days where daily minimum temperature >= 20 degrees                   |
+--------+----------------+--------------------------------------------------------------------------------+
| ID     |     tasmax     | Nr of Ice days                                                                 |
+--------+----------------+--------------------------------------------------------------------------------+
| HD17   |        tas     | Heating degree days [sum of 17 degrees - mean temperature]                     |
+--------+----------------+--------------------------------------------------------------------------------+
| GD4    |        tas     | Growing degree days [sum of TG >= 4 degrees]                                   |
+--------+----------------+--------------------------------------------------------------------------------+
| PRCPTOT|         pr     | Precipitation flux mean (mon / year)                                           |
+--------+----------------+--------------------------------------------------------------------------------+
| RR1    |         pr     | Nr of days with precipitation > 1 mm                                           |
+--------+----------------+--------------------------------------------------------------------------------+
| CWD    |         pr     | Consecutive wet days                                                           |
+--------+----------------+--------------------------------------------------------------------------------+
| CDD    |         pr     | Consecutive dry days                                                           |
+--------+----------------+--------------------------------------------------------------------------------+
| SDII   |         pr     | Simple daily intensity index for wet days [mm/wet day]                         |
+--------+----------------+--------------------------------------------------------------------------------+
| R10mm  |         pr     | Nr of days >10mm                                                               |
+--------+----------------+--------------------------------------------------------------------------------+
| R20mm  |         pr     | Nr of days with precipitation >= 20 mm                                         |
+--------+----------------+--------------------------------------------------------------------------------+
| RX1day |         pr     | Highest 1-day precipitation amount                                             |
+--------+----------------+--------------------------------------------------------------------------------+
| RX5day |         pr     | Highest 5-day precipitation amount                                             |
+--------+----------------+--------------------------------------------------------------------------------+
| SD     |       prsn     | Nr of snow days                                                                |
+--------+----------------+--------------------------------------------------------------------------------+
| SD1    |       prsn     | Nr of days with snow >= 1cm                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| SD5cm  |       prsn     | Nr of days with snow >= 5cm                                                    |
+--------+----------------+--------------------------------------------------------------------------------+
| SD50cm |       prsn     | Nr of days with snow >= 50 cm                                                  |
+--------+----------------+--------------------------------------------------------------------------------+




* indice percentile based

_INDICESper_ = dict(
    TG10p=dict(variable='tas', description='Days with TG < 10th percentile of daily mean temperature (cold days) (days)'),
    TX10p=dict(variable='tasmax', description='Days with TX < 10th percentile of daily maximum temperature (cold day-times) (days)'),
    TN10p=dict(variable='tasmin', description='Days with TN < 10th percentile of daily minimum temperature (cold nights) (days)'),
    TG90p=dict(variable='tas', description='Days with TG > 90th percentile of daily mean temperature (warm days) (days)'),
    TX90p=dict(variable='tasmax', description='Days with TX > 90th percentile of daily maximum temperature (warm day-times) (days)'),
    TN90p=dict(variable='tasmin', description='Days with TN > 90th percentile of daily minimum temperature (warm nights) (days)'),
    WSDI=dict(variable='tasmax', description='Warm-spell duration index (days)'),
    CSDI=dict(variable='tasmin', description='Cold-spell duration index (days)'),
    R75p=dict(variable='pr', description= 'Days with PRCPTOT > 75th percentile of daily amounts (moderate wet days) (days)'),
    R75pTOT=dict(variable='pr', description= 'Precipitation fraction due to moderate wet days (>75th percentile) (%)'),
    R95p=dict(variable='pr', description= 'Days with PRCPTOT > 95th percentile of daily amounts (very wet days) (days)'),
    R95pTOT=dict(variable='pr', description= 'Precipitation fraction due to very wet days (>95th percentile) (%)'),
    R99p=dict(variable='pr', description= 'Days with PRCPTOT > 99th percentile of daily amounts (extremely wet days)(days)'),
    R99pTOT=dict(variable='pr', description= 'recipitation fraction due to extremely wet days (>99th percentile)(%)'),
    )  
    

.. _ensemble_Robustness:

Robustness of an ensemble
-------------------------

Calculates the robustness as the ratio of noise to signal in an ensemle of timeseries


.. _segetalflora: 

Segetalflora
------------
Species biodiversity of segetal flora. Imput files: variable:tas , domain: EUR-11 or EUR-44

.. _sdm: 

Species Distribution Model
--------------------------

Statistical approach to calculate the spatial favorability of climate sensitive species.

The appraoch is to be performed in two steps:

* Statistical training with species presents absense data and historical climate data
* future projection based on the statistical training

.. _subset_countries: 

Subset Counties 
---------------

generates a polygon subset of input netCDF files 


Based on an ocgis call, several predfined polygons ( world counties ) can be used to generate an appropriate subset of input netCDF files. 
The option 'MOSAIK' as an checkbox allows you to decide in case of multiple polygon selection, if the polygons are stiched together to one polygon (e.g. shape of Germany and France as one polygon) or calculated as seperte output files. 

For optimisation of processing the subset, the appropriate shapefile are prepared with the following stepps: 


.. toctree::
   :maxdepth: 1

   shapefilepreparation
   
.. _visualisation: 

Visualisation
-------------

Time series visualisation of netCDF files. 
Creating a spagetti plot and an uncertainty plot.


.. _weatherregimes:

Weather Regimes
---------------

Calculation of weatherregimes based on pressure patterns (kmean method). The processes is performing a pattern clusterfication for observations data ( NCEP ) as well as to model data. both results are compared
 
processing stepps: 

* fetching observation data 
* fetching model data
 
