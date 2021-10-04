import streamlit as st
import os
import spacy
from spacy import displacy
import jsonlines
import PyPDF2

from app_utils import extract_text_from_pdf, visualize_entity_ruler, create_skill_set
from pdf_reader import pdfparser

PROJECT_DIR = os.path.dirname(os.getcwd()) + '/mesure/'
HTML_WRAPPER = """<div style="overflow-x: auto; border: 1px solid #e6e9ef; border-radius: 0.25rem; padding: 1rem; 
margin-bottom: 2.5rem">{}</div>"""

skill_pattern_path = PROJECT_DIR + "data/skill_patterns.jsonl"
file = PROJECT_DIR + '/CV/Philippe_Nguyen_CV_08_21.pdf'
nlp = spacy.load('en_core_web_sm')
pdfreader = "textract"

st.title('CV analysis')

with jsonlines.open(PROJECT_DIR + "data/skill_patterns.jsonl") as f:
    created_entities = [line['label'].upper() for line in f.iter()]

ruler = nlp.add_pipe("entity_ruler", after='parser')
ruler.from_disk(skill_pattern_path)


def get_skills(text_input):
    doc = nlp(text_input)
    html = displacy.render(doc, style="ent", options={"ents": created_entities})
    html = html.replace("\n", " ")
    return HTML_WRAPPER.format(html), create_skill_set(doc)


st.subheader("STEP 1. Skills extraction from CV:")
uploaded_file = st.file_uploader("Upload your CV here", type=['pdf'])
if uploaded_file is not None:
    fileReader = PyPDF2.PdfFileReader(uploaded_file)
    page_count = fileReader.getNumPages()
    # element = [fileReader.getPage(i).extractText() for i in range(page_count)]
    text = pdfparser(uploaded_file)

    # st.subheader("PDF file content:")
    # st.write(text[300:1000])

    # visualize_entity_ruler(created_entities, doc)

    skills, skills_set = get_skills(text)
    st.write(skills, unsafe_allow_html=True)

    st.subheader("Skills set:")
    st.write(skills_set, unsafe_allow_html=True)

# text = extract_text_from_pdf(file, pdfreader)

st.subheader("STEP 2. Skills extraction from job offer:")
st.write("Get some inspiration [here](https://www.ehlgroup.com/fr/a-propos/emplois/data-scientist)")
user_input = st.text_area("Copy paste the job offer here")

if st.button("Run skill extraction from text input", key="step2"):
    print(user_input)
    user_input_skills, user_input_skills_set = get_skills(user_input)
    st.write(user_input_skills, unsafe_allow_html=True)

    st.subheader("Job offer skills set:")
    st.write(user_input_skills_set, unsafe_allow_html=True)

    intersection = HTML_WRAPPER.format(user_input_skills_set.intersection(skills_set))
    st.subheader("Common skills set:")
    st.write(intersection, unsafe_allow_html=True)