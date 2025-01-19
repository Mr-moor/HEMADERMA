import 'package:flutter/material.dart';

class HematocritPage extends StatelessWidget {
  final List<String> diseases = [
    'Anaemia',
    'Cancer',
    'Lymphoma',
    'LEUKEMIA',
    'Hemophilia',
    'Thalasemia',
    // Add more diseases as needed
  ];

  final Map<String, String> diseaseDetails = {
    'Cancer': 'Cancer is a group of diseases involving abnormal cell growth with the potential to invade or spread to other parts of the body.\n\n'
        'Other names:\n'
        '- Malignant Tumor\n'
        '- Malignant Neoplasm\n\n'
        'Causes:\n'
        '-Smoking Tobaco\n'
        '-Diet and physical activity\n'
        '-Virus and other infections\n\n'
        'Signs:\n'
        'A sore that doesnt heal or continues to bleed or a lamp or thickening on the skin\n'
        'A thickening or lump anywhere on the body\n'
        'unusual bleeding or discharge in any body opening\n'
        'A persistent change in bowel or bladder habits\n'
        'A persistent cough or Hoarseness\n\n'
        'Cancer Causing Agents In The Environment\n'
        '-Aflatoxins\n'
        '-Aristolochic Acid\n'
        '-Arsenic\n'
        '-Asbestos\n'
        '-Benzene\n'
        '-Benzedine\n'
        '-Berillium\n'
        '-1 & 3-Butadine\n\n'
        'Types of cancer:\n'
        '- Carcinoma\n'
        '- Sarcomas\n'
        '- Leukemia\n'
        '- Lymphomas (non-hodgekin)\n\n'
        'CARCINOMAS\n'
        'Begins in the skin or the tissues that covers the surface of internal organs and glands and its the most common\n'
        'it begins in the epithelial tissue of the skin,or in the tissues that lines internal organs eg liver,kidney\n'
        'They may spread to other parts of the body or be confined at the primary location\n\n'
        'Types Of Carcinoma Cells\n'
        '-Basal Cell Carcinoma\n'
        '-Squamous Cell Carcinoma\n'
        '-Renal Cell Carcinoma\n'
        '-Ductal Carcinoma in Situ\n'
        '-Invasive Ductal Carcinoma\n'
        '-Adenocarcinoma\n\n'
        'Basal Cell Carcinoma\n'
        'Basal Cell-A type of cell within the skin that produces new skin as old ones die off\n'
        'Basal cell Carcinoma- often happens as a slightly transparent bump on the skin,though it can take other forms\n\n'
        'Causes\n'
        'Caused by damaged and subsequent DNA changes to the basal cell in the outermost layer of skin\n'
        'Exposure to UltraViolet(UV) radiation from the sun and indoor tanning\n'
        'is basal cell carcinoma a malignant or benign?\n'
        'Malignant-something harmfull or malignant that spreads rapidly\n'
        'Benign-something that does not pose any serious threat to your health\n'
        'Bsal infection is a benign\n\n'
        'Treatment\n'
        'Surgical excission-> in the procedure the doctor cuts out cancerous lessions and a sorrounding margin of healthy skin\n'
        'Mohs surgery-> the doctor removes the cancer layer by layer examining each layer under the microscope untill no abnormal cells remain\n'
        'What happens if you dont treat basal cell carcinoma?\n'
        '-The cancer develops roots that can project into a local structure hence spreading to the muscles and bone causing further damage\n\n'
        'Squamous Cel Carcinoma\n'
        'second most common form of skin cancer,ussually found in areas of the body damaged by Uv rays\n\n'
        'causes\n'
        '-uv rays\n\n'
        'Appearences\n'
        'may appear as flat redish or brownish patches in the skin\n\n'
        'spreading\n\n'
        'It rarely metamasizes(spreads to other parts of the body)\n'
        'its a benign hence doesnt spread rapidly\n'
        'it spreads slowly to the tissues,bones and lymph nodes\n\n'
        'Stages\n'
        'it occurs in four stages:\n'
        'Stage 0:\n'
        'Termed as Carcinoma in Situ\n'
        'The stage is not that invasive since abnorminal cells are only in the upper layer of the skin\n\n'
        'Stage 1 & 2:\n'
        'signs and symptoms starts to appear\n\n'
        'Stage 3(iiiA):\n'
        'Cancer has spread into the mucasa layer,thin muscle layer or submucosa layer of the oesophagus wall\n'
        'Cancer is found in 3 to 6 lymph nodes near Tumor\n\n'
        'Stage 4:\n'
        'The cancer can be any size and has metastasized to one or more lymph nodes\n\n'
        'Treatment:\n'
        'Radiation therapy and chemotherapy may be needed in serious cases\n'
        'Simple excission->The doctor cuts out the cancerous tisuues and a sorrounding margin of the healthy skin\n'
        'Mohs Surgery->Removal of cancer layer by layer\n\n'
        'Why squamous cell carcinoma keeps coming back:\n'
        'its becouse individuals who were diagnosed and treated have an increased risk of developing a second lession in the same location or near by the skin'
        ,
        'LEUKEMIA':
        'A Comprehensive Overview'
'Leukemia is a type of cancer that originates in the blood-forming tissues, such as the bone marrow and the lymphatic system, leading to the uncontrolled production of abnormal white blood cells. \n'
'These cancerous white blood cells crowd out the healthy ones, impairing the body\'s ability to fight infections and produce normal blood cells.\n\n'
'1. What Is Leukemia?\n'
'Leukemia is a broad term for cancers of the blood cells, particularly affecting the white blood cells. \n'
'These abnormal cells proliferate uncontrollably and accumulate in the blood and bone marrow, disrupting the normal function of blood cells.\n\n'
'2. Signs and Symptoms of Leukemia\n'
'The symptoms of leukemia can vary, but common signs include:\n'

'Fatigue or weakness: Due to the decreased number of healthy red blood cells.\n'
'Frequent infections: Abnormal white blood cells can\'t effectively fight infection\n'
'Unexplained weight loss: Rapid, unintended loss of weight can occur.\n'
'Bleeding or bruising easily: Reduced platelets cause problems with blood clotting.\n'
'Bone or joint pain: Abnormal cells can accumulate in joints and bones.\n'
'Swollen lymph nodes, liver, or spleen: Leukemia cells can gather in these areas, causing swelling.\n'
'Frequent fevers or night sweats: Reflecting an ongoing struggle in the body.\n'
'Pale skin: Anemia (low red blood cells) leads to paleness.\n\n'
 '3. Causes of Leukemia:\n'
'While the exact causes are not fully understood, leukemia develops due to mutations in the DNA of blood cells.\n'
' These mutations cause blood cells to grow and divide more rapidly and survive longer than normal cells.\n\n'

'Key factors include:\n'

'Genetic predisposition: People with genetic disorders like Down syndrome are at a higher risk.\n'
'Radiation exposure: Exposure to high levels of radiation (e.g., from cancer treatment) can trigger leukemia.\n'
'Chemical exposure: Long-term exposure to chemicals like benzene has been linked to leukemia.\n'
'Smoking: Tobacco smoke contains carcinogens that may contribute to the development of leukemia.\n'
'Previous cancer treatment: People who have undergone chemotherapy or radiation therapy for other cancers have an increased rise\n\n'
'.4. Types of Leukemia\n'
'Leukemia is classified based on how quickly it progresses and the type of white blood cell affected.\n'
' The main types include:\n'

'Acute Lymphoblastic Leukemia (ALL): The most common type in children, but it also affects adults. ALL involves the rapid production of immature lymphocytes.\n'
'Acute Myeloid Leukemia (AML): Affects both children and adults. AML causes the rapid growth of abnormal myeloid cells.\n'
'Chronic Lymphocytic Leukemia (CLL): The most common chronic leukemia in adults, CLL involves the accumulation of mature but abnormal lymphocytes.\n'
'Chronic Myeloid Leukemia (CML): Affects adults primarily and involves the growth of mature but abnormal myeloid cells.\n\n'
 '5. Methods of Treatment\n'
'Leukemia treatment depends on the type and severity of the disease but generally includes:\n'

'Chemotherapy:\n'

'The main treatment for most types of leukemia. Chemotherapy uses drugs to kill leukemia cells or stop their growth.\n\n'
'Targeted therapy:\n'

'Drugs that specifically target certain vulnerabilities of leukemia cells, like tyrosine kinase inhibitors (used for CML).\n\n'
'Radiation therapy:\n'

'High-energy radiation can be used to destroy leukemia cells or shrink enlarged organs affected by leukemia.\n\n'
'Stem cell transplant (Bone marrow transplant):\n'

'Replaces the diseased bone marrow with healthy stem cells that can regenerate normal blood cells.\n'
'Immunotherapy:\n'

'Boosts the body\'s immune system to help it recognize and destroy cancer cells.\n\n'
'6. Control Measures and Preventive Steps\n'
'While leukemia cannot be fully prevented, certain steps can lower the risk:\n\n'

'Control Measures:\n'

'Avoid exposure to harmful chemicals and radiation: Limiting exposure to known carcinogens like benzene.\n'
'Quit smoking: Reducing the risk by avoiding tobacco products.\n\n'
'Preventive Steps:\n'

'Regular medical checkups: Early detection of abnormal blood counts through routine tests can help.\n'
'Healthy lifestyle: Maintaining a balanced diet, regular exercise, and avoiding environmental toxins may lower the risk.\n\n'
'7. Effects of Leukemia:\n'
'Leukemia can have serious, life-altering effects, such as:\n'

'Physical effects: Fatigue, infections, and bleeding problems.\n'
'Psychological effects: Anxiety, depression, and emotional stress from living with a chronic illness.\n'
'Economic impact: Leukemia treatments can be expensive and lead to financial strain.\n\n'
'8. Conclusion:\n'
'Leukemia is a complex group of blood cancers with various types and symptoms. \n'
'While it can be life-threatening, advancements in treatment like chemotherapy, stem cell transplants, and targeted therapies offer hope for those affected.\n'
' Early detection and treatment are key to managing the disease effectively.'
,
    'Lymphoma':
        'A Comprehensive Overview\n'
'Lymphoma is a type of cancer that begins in the lymphatic system, which is a part of the immune system.\n'
'The lymphatic system includes the lymph nodes, spleen, thymus, and bone marrow. Lymphoma occurs when lymphocytes (a type of white blood cell) grow uncontrollably, forming tumors in the lymph nodes or other parts of the body.\n\n'
' 1. What Is Lymphoma?\n'
'Lymphoma is a cancer of the lymphatic system. It specifically targets lymphocytes, a type of white blood cell that plays a role in fighting infections.\n'
'The abnormal lymphocytes can accumulate in the lymph nodes, spleen, or other organs, leading to the formation of tumors.\n\n'
'2. Signs and Symptoms of Lymphoma\n'
'Painless swelling of lymph nodes: Often occurs in the neck, armpits, or groin.\n'
'Fatigue: A general feeling of tiredness or weakness.\n'
'Fever and night sweats: Unexplained fevers or excessive sweating during sleep.\n'
'Weight loss: Sudden, unexplained weight loss.\n'
'Itching: Persistent itching, particularly in the lower extremities.\n'
'Loss of appetite: Decreased interest in eating.\n'
'Shortness of breath or chest pain: If lymphoma affects the chest area, it can cause breathing difficulties.\n\n'
'3. Causes of Lymphoma\n'
'The exact cause of lymphoma is not known, but several factors may contribute to the risk of developing the disease.\n\n'

'Key factors include:\n'

'Genetic mutations: Abnormal changes in the DNA of lymphocytes can lead to uncontrolled growth.\n'
'Weakened immune system: People with weakened immune systems (e.g., from HIV/AIDS or immunosuppressive drugs) are at a higher risk.\n'
'Infections: Certain infections, such as Epstein-Barr virus (EBV) or Helicobacter pylori, are linked to an increased risk of lymphoma.\n'
'Age and gender: Lymphoma is more common in older adults and slightly more common in males.\n\n'
'4. Types of Lymphoma\n'
'There are two main types of lymphoma:\n'

'Hodgkin Lymphoma (HL): Characterized by the presence of Reed-Sternberg cells, Hodgkin lymphoma is less common but highly treatable.\n'
'It often starts in the lymph nodes of the upper body.\n'

'Non-Hodgkin Lymphoma (NHL): A broad category that includes many subtypes, NHL is more common than Hodgkin lymphoma.\n'
'It can arise in various parts of the body and varies in aggressiveness.\n\n'

'5. Methods of Treatment\n'
'Treatment for lymphoma depends on the type and stage of the cancer:\n'

'Chemotherapy:\n'

'Uses drugs to kill cancerous lymphocytes and stop their growth.\n'
' Its a common treatment for both Hodgkin and non-Hodgkin lymphoma.\n\n'
'Radiation therapy:\n'

'High-energy rays are used to destroy cancer cells in localized areas, often combined with chemotherapy.\n\n'
'Immunotherapy:\n'

'Drugs like monoclonal antibodies help the immune system recognize and destroy cancer cells.\n\n'
'Stem cell transplant:\n'

'Used in aggressive cases, this procedure replaces damaged bone marrow with healthy stem cells to regenerate normal blood cells.\n'
'Targeted therapy:\n'

'Targets specific molecules in lymphoma cells, such as the use of drugs like rituximab for B-cell lymphoma.\n\n'
'6. Control Measures and Preventive Steps \n'
'Control Measures:\n'

'Early diagnosis and treatment: Regular checkups and early treatment of infections or immune-related conditions can help reduce risk.\n\n'
'Preventive Steps:\n'

'Avoid exposure to risk factors: Limit exposure to harmful chemicals, radiation, and infections like EBV.\n'
'Manage immunosuppressive conditions: Keeping immune-related disorders under control can reduce the risk of lymphoma.\n\n'
'7. Effects of Lymphoma\n'
'Lymphoma can lead to a range of effects:\n'

'Physical effects: Fatigue, weight loss, and compromised immune function.\n'
'Psychological effects: Anxiety and depression are common, especially during treatment.\n'
'Long-term effects: Survivors may face complications from treatment, such as secondary cancers or heart disease.\n\n'
'8. Conclusion\n'
'Lymphoma is a cancer of the lymphatic system with varying degrees of severity depending on the type (Hodgkin or Non-Hodgkin).\n'
'With advances in treatments like chemotherapy, radiation, and immunotherapy, the outlook for many people with lymphoma is improving, especially with early diagnosis and treatment.',

'Anaemia':
'A Comprehensive Overview:\n\n'
'Anemia is a condition in which the body lacks enough healthy red blood cells to carry adequate oxygen to the body tissues.\n'
' There are several types of anemia, each with different causes.\n\n'
' 2. Signs and Symptoms of Anemia\n'
'Fatigue and weakness\n'
'Pale or yellowish skin\n'
'Shortness of breath\n'
'Dizziness or lightheadedness\n'
'Chest pain or rapid heartbeat\n'
'Cold hands and feet\n'
'Headaches\n\n'
 '3. Causes of Anemia\n'
'There are many causes of anemia, but they generally fall into three categories:\n'

'Blood loss: Heavy menstrual periods, ulcers, trauma, or gastrointestinal bleeding can lead to anemia.\n'
'Decreased or faulty red blood cell production: The body may produce too few red blood cells or produce defective cells.\n'
' This is common in conditions like iron deficiency, vitamin B12 deficiency, or bone marrow disorders.\n'
'Destruction of red blood cells: In certain diseases like hemolytic anemia, the body destroys red blood cells faster than they can be produced.\n\n'
'4. Types of Anemia:\n'
'Iron-deficiency anemia: Caused by a lack of iron, preventing the body from making enough hemoglobin.\n'
'Vitamin-deficiency anemia: Deficiency in folate or vitamin B12 affects red blood cell production.\n'
'Hemolytic anemia: The body destroys red blood cells prematurely.\n'
'Aplastic anemia: A rare condition in which the body stops producing enough blood cells.\n'
'Sickle cell anemia: A genetic disorder that produces abnormally shaped red blood cells that break down easily.\n\n'
'5. Methods of Treatment:\n'
'Iron supplementation: Used for iron-deficiency anemia.\n'
'Vitamin B12 or folate supplements: For anemia caused by vitamin deficiencies.\n'
'Blood transfusions: Used in severe cases of anemia or blood loss.\n'
'Erythropoiesis-stimulating agents (ESAs): Stimulate the production of red blood cells.\n'
'Bone marrow transplant: Used for aplastic anemia or other serious cases.\n'
'Treatment of underlying causes: If anemia is caused by chronic diseases, addressing the root cause can alleviate symptoms.\n\n'
'6. Control Measures and Preventive Steps:\n'
'Iron-rich diet: Eating foods high in iron, such as red meat, beans, and spinach, can prevent iron-deficiency anemia.\n'
'Vitamin supplementation: Ensuring adequate intake of vitamin B12 and folate is important for preventing anemia.\n'
'Regular checkups: Routine blood tests can detect anemia early and prevent complications.\n'
'Avoid exposure to toxins: Certain chemicals can cause anemia, so minimizing exposure is key.\n\n'
'7. Effects of Anemia\n'
'Without adequate treatment, anemia can lead to:\n'

'Severe fatigue\n'
'Heart problems (such as an enlarged heart or heart failure)\n'
'Complications during pregnancy (for pregnant women)\n'
'Developmental delays in children\n\n'
'8. Conclusion:\n'
'Anemia is a common condition that can range from mild to severe. \n'
'Treatment is based on the type and cause of anemia, and early detection is essential for managing the condition effectively.'
,
'Hemophilia':
'A Comprehensive Overview\n'
'Hemophilia is a rare genetic disorder in which the blood doesnt clot normally because it lacks sufficient blood-clotting proteins (clotting factors). This leads to prolonged bleeding after an injury.\n\n'
'1. What Is Hemophilia?\n'
'Hemophilia is a bleeding disorder that slows the blood clotting process.\n'
' It primarily affects males and is inherited in an X-linked recessive pattern.\n'
' There are two main types: Hemophilia A (deficiency of factor VIII) and Hemophilia B (deficiency of factor IX).\n\n'
'2. Signs and Symptoms of Hemophilia\n'
'Excessive bleeding from cuts or injuries\n'
'Spontaneous bleeding into joints or muscles\n'
'Prolonged nosebleeds\n'
'Heavy bleeding after surgery or dental work\n'
'Blood in urine or stool\n'
'Joint pain or swelling due to internal bleeding\n\n'
 '3. Causes of Hemophilia\n'
'Hemophilia is caused by a genetic mutation on the X chromosome that affects clotting factor production.\n'
'Females are typically carriers, while males with the mutation express the disease.\n\n'

'4. Types of Hemophilia\n'
'Hemophilia A: Caused by a deficiency of clotting factor VIII.\n'
'Hemophilia B: Caused by a deficiency of clotting factor IX.\n\n'
'5. Methods of Treatment:\n'
'Clotting factor replacement therapy: Regular infusions of clotting factor VIII or IX to prevent or treat bleeds.\n'
'Desmopressin (DDAVP): A medication that can stimulate the release of stored clotting factors in some people with mild hemophilia\n'
'Antifibrinolytic medicines: Help to prevent clots from breaking down.\n'
'Physical therapy: For joint health and rehabilitation after bleeds.\n'
'Gene therapy: Under investigation as a potential cure by introducing a functional copy of the affected gene.\n\n'
'6. Control Measures and Preventive Steps:\n'
'Avoid injury: People with hemophilia should avoid activities that could lead to injury or trauma.\n'
'Prophylactic clotting factor infusions: Regular infusions of clotting factor can prevent spontaneous bleeding episodes.\n'
'Vaccination: Hepatitis vaccinations are important since individuals with hemophilia may require frequent blood products, increasing infection risk.\n\n'

'7. Effects of Hemophilia\n'
'If untreated, hemophilia can lead to:\n'

'Chronic joint damage\n'
'Severe internal bleeding\n'
'Neurological problems if bleeding occurs in the brain \n\n'
'8. Conclusion\n'
'Hemophilia is a lifelong condition that requires careful management and regular treatment.\n'
' Advances in treatment have greatly improved the quality of life for individuals with hemophilia, and gene therapy holds potential for future cures.\n\n'

,
'Thalasemia':
'A Comprehensive Overview\n'
'Thalassemia is an inherited blood disorder that affects the bodys ability to produce hemoglobin and red blood cells.\n'
' It leads to anemia and can range from mild to severe.\n\n'
'1. What Is Thalassemia?\n'
'Thalassemia is a genetic condition where the production of hemoglobin is abnormal.\n'
'Hemoglobin is the oxygen-carrying component of red blood cells.\n'
' Insufficient or abnormal hemoglobin leads to the destruction of red blood cells and anemia.\n\n'
'2. Signs and Symptoms of Thalassemia:\n'
'Fatigue and weakness\n'
'Pale or yellowish skin\n'
'Facial bone deformities\n'
'Slow growth in children\n'
'Dark urine\n'
'Abdominal swelling due to an enlarged spleen\n\n'
'3. Causes of Thalassemia:\n'
'Thalassemia is caused by mutations in the genes responsible for hemoglobin production.\n' 
'It is inherited in an autosomal recessive pattern.\n\n'

'4. Types of Thalassemia:\n'
'Alpha thalassemia: Caused by mutations in the alpha globin gene. Severity depends on the number of affected genes.\n'
'Beta thalassemia: Caused by mutations in the beta globin gene.\n'
'It ranges from mild (beta-thalassemia minor) to severe (beta-thalassemia major or Cooleys anemia).\n\n'
'5. Methods of Treatment:\n'
'Blood transfusions: Frequent transfusions are required to maintain healthy red blood cell levels in severe cases.\n'
'Iron chelation therapy: To prevent iron overload due to frequent transfusions.\n'
'Bone marrow transplant: A potential cure for thalassemia.\n'
'Folic acid supplements: To support red blood cell production.\n'
'Gene therapy: Being explored as a future treatment option.\n\n'
'6. Control Measures and Preventive Steps:\n'
'Genetic counseling: For families with a history of thalassemia, genetic counseling can help assess risks for offspring.\n'
'Prenatal screening: Available for at-risk families to detect the condition before birth.\n\n'

'7. Effects of Thalassemia:\n'
'Without treatment, thalassemia can cause:\n'

'Growth and developmental delays\n'
'Bone deformities\n'
'Heart disease\n'
'Organ damage due to iron overload\n\n'
' 8. Conclusion\n'
'Thalassemia is a serious inherited blood disorder that requires lifelong management.\n'
' Advances in treatments, such as:\n'
'blood transfusions\n'
'iron chelation and the potential for gene therapy, have improved outcomes for those affected.\n'
   , // Add more details as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hematocrit Diseases'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.separated(
        itemCount: diseases.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              diseases[index],
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DiseaseDetailPage(
                    diseaseName: diseases[index],
                    diseaseDetail: diseaseDetails[diseases[index]] ?? '',
                  ),
                ),
              );
            },
          );
        },
        separatorBuilder: (context, index) => Divider(thickness: 1),
      ),
    );
  }
}

class DiseaseDetailPage extends StatelessWidget {
  final String diseaseName;
  final String diseaseDetail;

  DiseaseDetailPage({required this.diseaseName, required this.diseaseDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(diseaseName),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diseaseName,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              diseaseDetail,
              maxLines: null,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
