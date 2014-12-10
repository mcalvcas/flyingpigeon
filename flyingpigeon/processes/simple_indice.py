from malleefowl.process import WPSProcess

from malleefowl import wpslogging as logging
logger = logging.getLogger(__name__)

from flyingpigeon import indices_calculator

class CalcIndice(WPSProcess):
    """This process calculates a climate indice for the given input netcdf files."""

    def __init__(self):
        WPSProcess.__init__(
            self, 
            identifier = "simple_indice",
            title="Calculation of climate indice (simple)",
            version = "1.0",
            metadata=[],
            abstract="This process calculates a climate indice for the given input netcdf files."
            )

        indice_values = indices_calculator.indices()
        indice_abstract = indices_calculator.indices_description()

        self.resource = self.addComplexInput(
            identifier="resource",
            title="Resouce",
            abstract="NetCDF File",
            minOccurs=1,
            maxOccurs=100,
            maxmegabites=5000,
            formats=[{"mimeType":"application/x-netcdf"}],
            )

        self.grouping = self.addLiteralInput(
            identifier="grouping",
            title="Grouping",
            abstract="Select an aggregation grouping",
            default='year',
            type=type(''),
            minOccurs=1,
            maxOccurs=1,
            allowedValues=["year", "month", "sem"]
            )

        self.indice = self.addLiteralInput(
            identifier="indice",
            title="Indice",
            abstract=indice_abstract,
            default='SU',
            type=type(''),
            minOccurs=1,
            maxOccurs=1,
            allowedValues=indice_values
            )
      
        # complex output
        # -------------
        self.output = self.addComplexOutput(
            identifier="output",
            title="Indice",
            abstract="Calculated indice as NetCDF file",
            metadata=[],
            formats=[{"mimeType":"application/x-netcdf"}],
            asReference=True
            )
        
    def execute(self):
        resources = self.getInputValues(identifier='resource')

        import os
        self.show_status('starting: indice=%s, grouping=%s, num_files=%s, size:%s' % (self.indice.getValue(), self.grouping.getValue(), len(resources), os.path.getsize(resources[0])), 0)

        result = indices_calculator.calc_indice(
            resources = resources,
            indice = self.indice.getValue(),
            grouping = self.grouping.getValue(),
            out_dir = self.working_dir,
            )
        
        self.show_status('result %s' % result, 90)

        self.output.setValue( result )

        self.show_status('done: indice=%s, num_files=%s' % (self.indice.getValue(), len(resources)), 100)

