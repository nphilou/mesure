import sys
from io import StringIO

from pdfminer.pdfinterp import PDFResourceManager, PDFPageInterpreter
from pdfminer.pdfpage import PDFPage
from pdfminer.converter import XMLConverter, HTMLConverter, TextConverter
from pdfminer.layout import LAParams


def pdfparser(data):
    with StringIO() as output_string:
        rsrcmgr = PDFResourceManager()
        codec = 'utf-8'
        laparams = LAParams()
        device = TextConverter(rsrcmgr, output_string, codec=codec, laparams=laparams)
        # Create a PDF interpreter object.
        interpreter = PDFPageInterpreter(rsrcmgr, device)
        # Process each page contained in the document.

        for page in PDFPage.get_pages(data):
            interpreter.process_page(page)
            res = output_string.getvalue()

        return res
