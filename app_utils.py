import textract
from pdfminer.high_level import extract_text
from spacy import displacy


def extract_text_from_pdf(file, pdfreader):
    '''Opens and reads in a PDF file from path'''

    # fileReader = PyPDF2.PdfFileReader(open(file, 'rb'))
    # page_count = fileReader.getNumPages()
    # text = [fileReader.getPage(i).extractText() for i in range(page_count)]
    text_pdf = ""
    if pdfreader == "textract":
        text_pdf = str(textract.process(file)).replace("\\n", " ")
    elif pdfreader == "pdfminer":
        text_pdf = extract_text(file).replace("\n", " ")
    return text_pdf


def visualize_entity_ruler(entity_list, doc):
    '''Visualize the Skill entities of a doc'''

    options = {"ents": entity_list}
    displacy.render(doc, style='ent', options=options)


def create_skill_set(doc):
    '''Create a set of the extracted skill entities of a doc'''

    return set([ent.label_.upper().split('|')[1] for ent in doc.ents if 'SKILL' in ent.label_])