import 'package:flutter/material.dart';

class DermatologyPage extends StatelessWidget {
  final List<String> diseases = [
    'Acne',
    'Eczema',
    'Psoriasis',
    'Dermatitis',
    'Rosacea',
    'Vitiligo',
    'Hives(urticaria)',
    // Add more diseases as needed
  ];

  final Map<String, String> diseaseDetails = {
    'Acne':
        'A Comprehensive Overview\n\n'
'Acne is a common skin condition that affects millions of people worldwide, primarily during adolescence, but it can persist into adulthood or even appear for the first time in adulthood.\n' 
'It manifests as different types of blemishes, primarily on the face, chest, and back. While it\'s not life-threatening, it can cause emotional distress and lead to scarring if left untreated \n\n'
'1. What Is Acne?\n'
'Acne is a skin disorder that occurs when hair follicles (pores) become clogged with oil (sebum) and dead skin cells.\n'
' The condition leads to the formation of lesions or blemishes such as:\n'
'-pimples\n'
'-blackheads\n' 
'-whiteheads\n'
 'cysts and nodules.\n'
 'It is most commonly found on areas of the body that have the most oil glands:\n'
 '-the face\n'
 '-forehead\n'
 '-chest\n'
 '-upper back and shoulders\n\n'
 ' 2. Signs and Symptoms of Acne\n\n'
'Whiteheads (closed comedones): Small bumps that remain under the skin\'s surface.\n'
'Blackheads (open comedones): Pores that are clogged with oil and dead skin cells; they oxidize and turn black.\n'
'Papules: Small red or pink bumps on the skin, which may feel tender.\n'
'Pustules (pimples): Papules with pus at their tips, red at the base with white or yellow pus-filled centers.\n'
'Cysts: Painful, large, pus-filled lumps beneath the surface of the skin. Cysts can cause scars.\n'
'Nodules: Large, solid, painful lumps deep within the skin, which may lead to long-term scarring.\n\n'
' 3. Causes of Acne\n'
'Acne occurs when the sebaceous (oil) glands attached to the hair follicles are stimulated, often by hormonal changes.\n'
'The oil glands, stimulated by male hormones from the adrenal glands, produce excess sebum, which can mix with dead skin cells and clog pores.\n\n'

'Key factors contributing to acne include:\n'

'Excess oil production: Overactive oil glands result in sebum build-up in pores.\n'
'Clogged hair follicles: Dead skin cells mix with sebum to form a plug in the follicles.\n'
'Bacterial infection: Cutibacterium acnes (previously known as Propionibacterium acnes) can infect clogged pores, leading to inflammation.\n'
'Hormonal changes: Androgens increase during puberty and menstruation, causing more oil production.\n'
'Diet and lifestyle: Foods high in sugar, dairy, and carbohydrates, as well as stress, may contribute to acne formation.\n'
'Medications: Certain drugs, such as corticosteroids, lithium, and androgens, can aggravate acne.\n\n'
'4. Causative Agents\n'
'Hormones: Androgens are the main culprits behind increased oil production.\n'
'Bacteria: The bacterium Cutibacterium acnes plays a significant role in causing inflammation in clogged pores.\n'
'Genetics: Family history may predispose an individual to acne.\n'
'Cosmetic products: Oil-based cosmetics can clog pores, leading to acne.\n\n'
'5. Types of Acne\n'
'Acne Vulgaris: The most common type of acne, typically involving whiteheads, blackheads, papules, pustules, and nodules.\n'
'Acne Conglobata: A severe form of acne that involves deep nodules and cysts, leading to severe scarring.\n'
'Acne Mechanica: Acne triggered by heat, friction, and pressure, often seen in athletes (due to equipment or tight clothing).\n'
'Cystic Acne: A more severe form of acne where deep cysts form beneath the skin, leading to scarring.\n'
'Hormonal Acne: Acne triggered or worsened by hormonal changes, typically around the jawline and chin in women.\n\n'
'6. Methods of Treatment\n'
'There are various treatments for acne, depending on its severity. The goal of treatment is to reduce oil production, speed up skin cell turnover, reduce inflammation, and combat bacterial infection.\'s'

'Over-the-counter (OTC) treatments:\n\n'

'Benzoyl Peroxide: Reduces oil production and kills bacteria.\n'
'Salicylic Acid: Helps exfoliate the skin and keep pores from becoming clogged.\n'
'Retinoids: Promote cell turnover and prevent hair follicles from becoming clogged.\n\n'
'Prescription medications:\n'

'Topical Retinoids (e.g., Tretinoin): Help clear clogged pores.\n'
'Antibiotics (topical or oral): Reduce bacteria and inflammation.\n'
'Oral contraceptives (for women): Regulate hormones that may cause acne.\n'
'Isotretinoin (Accutane): A powerful drug used for severe acne, reducing oil production significantly.\n'
'Procedural treatments:\n\n'

'Chemical peels: Help remove the top layer of dead skin, improving acne.\n'
'Drainage and extraction: For removing large cysts or nodules.\n'
'Laser and light therapy: Target acne-causing bacteria and reduce oil production.\n\n'
'7. Control Measures and Preventive Steps\n\n'
'While acne cant always be completely prevented, several measures can help manage it and reduce flare-ups:\n\n'

'Control Measures:\n'

'Proper skin care: Clean the face with a gentle cleanser twice a day to remove excess oil and dirt.\n'
'Non-comedogenic products: Use makeup, sunscreen, and moisturizers labeled "oil-free" or "non-comedogenic."\n'
'Avoid touching the face: Frequent touching can transfer oils and dirt to the skin, clogging pores.\n'
'Shower after sweating: Sweat can irritate acne-prone skin.\n\n'
'Preventive Steps:\n'

'Maintain a healthy diet: Limit sugar, dairy, and refined carbohydrates.\n'
'Manage stress: Stress triggers hormonal changes that can worsen acne.\n'
'Stay hydrated: Water helps flush out toxins and keeps the skin clear.\n'
'Avoid excessive scrubbing: Over-exfoliating can irritate the skin and worsen acne.\n\n'
 '8. Effects of Acne\n\n'
'Physical effects: Acne can lead to permanent scarring and hyperpigmentation (dark spots). Severe forms like cystic acne can cause deep scars if left untreated.\n'
'Emotional effects: Acne often leads to low self-esteem, anxiety, and depression, especially in adolescents. Social withdrawal and body image issues are common.\n\n'
'9. Conclusion\n'
'Acne is a multifactorial skin condition influenced by hormonal changes, bacteria, diet, and lifestyle. While its severity can vary from mild to severe, its a manageable condition with the right treatment plan.\n'
' Treatment strategies range from over-the-counter remedies to prescription medications, and in some cases, procedural interventions. Preventing acne involves good skincare habits, lifestyle modifications, and sometimes medication to control the underlying causes.\n'
' Early treatment is key to avoiding the long-term effects of acne, such as scarring and emotional distress....',
    'Eczema':
        'A Comprehensive Overview\n\n'
'Eczema, also known as atopic dermatitis, is a chronic skin condition characterized by\n'
'-inflammation\n'
'-itching, and redness.\n'
'It affects people of all ages but is more common in infants and young children.\n'
' Eczema tends to flare up periodically, and while there is no cure, various treatments and management strategies can help alleviate symptoms.\n\n'
'1. What Is Eczema?\n'
'Eczema is an inflammatory skin condition that results in dry, itchy, and red patches on the skin.\n' 
' The condition arises from a combination of genetic and environmental factors, and it often occurs alongside other allergic conditions like asthma or hay fever.\n\n'

'2. Signs and Symptoms of Eczema\n'
'Dry skin: The skin becomes excessively dry, leading to rough patches.\n'
'Itching: The hallmark of eczema, itching can be severe and worsen at night.\n'
'Red to brownish-gray patches: These typically appear on the hands, feet, wrists, ankles, upper chest, eyelids, neck, and inside the bends of the elbows and knees.\n'
'Small, raised bumps: These may ooze fluid and crust over when scratched.\n'
'Thickened or cracked skin: Long-term scratching can lead to leathery or scaly skin.\n'
'Sensitive or swollen skin: Areas affected by eczema can become irritated, especially after scratching.\n\n'
'4. Causative Agents\n'
'Genetic predisposition: A family history of eczema or related allergic conditions can trigger the condition.\n'
'Environmental irritants: Soaps, detergents, fragrances, certain fabrics (like wool), and temperature changes.\n'
'Allergens: Pollen, dust mites, and pet dander can trigger or worsen eczema.\n'
'Microorganisms: Bacteria like Staphylococcus aureus and fungi can sometimes infect and exacerbate eczema.\n\n'
'5. Types of Eczema\n'
'Atopic Dermatitis: The most common form of eczema, associated with a faulty immune response.\n'
'Contact Dermatitis: Occurs when the skin reacts to a specific substance (e.g., chemicals, metals).\n'
'Seborrheic Dermatitis: Affects areas with many oil-producing glands (scalp, face) and causes dandruff.\n'
'Dyshidrotic Eczema: Causes small blisters on the hands and feet, often in response to stress, moisture, or allergens.\n'
'Nummular Eczema: Circular, coin-shaped spots of irritated skin that are distinct from other types of eczema.\n'
'Stasis Dermatitis: Occurs on the lower legs due to poor circulation, leading to irritated skin and ulcers.\n\n'
'6. Methods of Treatment\n'
'While there is no cure for eczema, treatments aim to control symptoms and prevent flare-ups.\n'

'Topical Treatments:\n'

'Moisturizers: Applied regularly to maintain skin hydration and reduce dryness.\n'
'Topical corticosteroids: Reduce inflammation and itching. They come in various strengths depending on severity.\n'
'Topical calcineurin inhibitors (e.g., tacrolimus): Non-steroid creams that help control inflammation.\n\n'
'Systemic Treatments:\n'

'Oral corticosteroids: Used in severe cases to reduce widespread inflammation.\n'
'Immunosuppressants: For severe eczema, drugs like cyclosporine or methotrexate can be prescribed.\n'
'Biologics: Newer treatments like dupilumab target specific parts of the immune system involved in eczema.\n\n'
'Lifestyle Treatments:\n'

'Wet wrap therapy: Moisturizing the skin, then wrapping it in damp bandages to promote hydration and calm inflammation.\n'
'Light therapy (phototherapy): Controlled exposure to UV light can reduce symptoms in chronic cases.\n'
'7. Control Measures and Preventive Steps\n'
'Control Measures:\n'

'Moisturizing regularly: Apply thick moisturizers immediately after bathing to lock in moisture.\n'
'Avoiding triggers: Identifying and avoiding environmental triggers like specific detergents or allergens can help.\n'
'Wearing breathable fabrics: Choose cotton over wool or synthetic fabrics that can irritate the skin.\n'
'Gentle skincare products: Use mild, fragrance-free soaps and cleansers.\n\n'
'Preventive Steps:\n'

'Stay hydrated: Drink enough water to maintain skin moisture from the inside.\n'
'Maintain a healthy diet: Avoid foods that may cause allergic reactions (common allergens include eggs, dairy, and soy).\n'
'Manage stress: Stress can worsen eczema, so techniques like meditation or yoga may help reduce flare-ups.\n'
'Bathe wisely: Limit showers to 10 - 15 minutes with warm water (not hot) and pat the skin dry instead of rubbing.\n'
'8. Effects of Eczema\n'
'Physical effects: In severe cases, eczema can cause permanent thickening of the skin (lichenification), darkened skin patches, and infections.\n'
'Psychological effects: Eczema is linked to stress, anxiety, and depression, especially in chronic sufferers, due to constant discomfort, itching, and cosmetic concerns.\n\n'
'9. Conclusion\n'
'Eczema is a complex, chronic skin condition with a strong genetic component. Although theres no cure, it can be managed effectively through proper skincare, trigger avoidance, and medication. Early diagnosis and treatment are crucial for reducing long-term physical and psychological effects.\n'
,
    'Psoriasis':
        'A Comprehensive Overview\n\n'
'Psoriasis is a chronic autoimmune condition that speeds up the life cycle of skin cells, leading to the rapid buildup of cells on the skins surface.\n'
'This results in the formation of scaly, thick patches that can be itchy or painful. Like eczema, psoriasis has no cure but can be managed effectively.\n'

'1. What Is Psoriasis?\n'
'Psoriasis is an autoimmune disease in which the skin cells multiply faster than normal.\n'
'This accelerated growth causes skin cells to accumulate and form thick, red, scaly patches, known as plaques.\n'
' These plaques can appear anywhere on the body but are most commonly found on the scalp, elbows, knees, and lower back.\n'

'2. Signs and Symptoms of Psoriasis\n'
'Red patches of skin: Often covered with thick, silvery scales (plaques)\n'
'Dry, cracked skin: This skin may bleed in severe cases.\n'
'Itching and burning: Psoriasis plaques can be intensely itchy or even painful.\n'
'Thickened, pitted nails: Psoriasis can affect the nails, causing them to become brittle or separated from the nail bed.\n'
'Stiff, swollen joints: In some cases, psoriasis can lead to psoriatic arthritis, a condition that affects the joints.\n\n'
'3. Causes of Psoriasis\n'
'Psoriasis is an autoimmune disorder, meaning the bodys immune system mistakenly attacks healthy cells.\n'
'It is believed to be triggered by a combination of genetic, immune system, and environmental factors.\n'

'Key factors include:\n'

'Genetic predisposition: A family history of psoriasis increases the risk of developing the condition.\n'
'Immune system dysfunction: The immune system mistakenly speeds up skin cell turnover.\n'
'Triggers: Stress, skin injuries (scrapes, cuts), infections, medications (like beta-blockers and antimalarial drugs), and weather changes can trigger flare-ups.\n\n'
'4. Causative Agents\n'
'Genetic factors: Psoriasis tends to run in families.\n'
'Immune system: The immune systems overreaction is the direct cause of the rapid skin cell turnover.\n'
'Environmental triggers: Infections, cold weather, stress, and certain medications can trigger psoriasis.\n\n'
'5. Types of Psoriasis\n'
'Plaque Psoriasis: The most common form, with raised red patches covered by silvery-white scales.\n'
'Guttate Psoriasis: Characterized by small, dot-like lesions, often triggered by a bacterial infection.\n'
'Inverse Psoriasis: Found in skin folds (groin, armpits), and is red and smooth, without scales.\n'
'Pustular Psoriasis: Causes white pustules surrounded by red skin.\n'
'Erythrodermic Psoriasis: A severe form of psoriasis involving widespread redness and shedding of the skin.\n'
'Nail Psoriasis: Affects nails, causing them to become pitted, thickened, or discolored.\n\n'
'6. Methods of Treatment\n'
'Psoriasis treatment aims to slow skin cell turnover and reduce inflammation.\n\n'

'Topical Treatments:\n'

'Topical corticosteroids: Reduce inflammation and itching.\n'
'Vitamin D analogs (e.g., calcipotriene): Slow down the growth of skin cells.\n'
'Coal tar: Reduces scaling, itching, and inflammation.\n\n'
'Systemic Treatments:\n'

'Methotrexate: An immunosuppressant used for severe psoriasis.\n'
'Biologics (e.g., infliximab, etanercept): Target specific parts of the immune system involved in psoriasis.\n'
'Oral retinoids: Help normalize skin cell growth.\n\n'
'Light Therapy:\n'

'Phototherapy (UVB light): Exposes the skin to ultraviolet light under medical supervision, reducing scaling and inflammation.\n\n'
'7. Control Measures and Preventive Steps \n\n'
'Control Measures:\n'

'Moisturize daily: Keeping the skin hydrated helps prevent flare-ups.\n'
'Use medicated shampoos: These can help control psoriasis of the scalp.\n'
'Avoid triggers: Stress, injuries, and certain medications can trigger psoriasis.\n\n'
'Preventive Steps:\n'

'Healthy diet: Some find a diet rich in anti-inflammatory foods can help.\n'
'Limit alcohol: Alcohol can trigger or worsen psoriasis in some individuals.\n'
'Sunlight exposure: In moderate amounts, sunlight can improve psoriasis symptoms.\n\n'
'8. Effects of Psoriasis\n'
'Physical effects: Psoriasis can cause painful, unsightly plaques that can affect daily life.\n'
'Psychological effects: The appearance of psoriasis can lead to anxiety, depression, and social isolation.\n\n'
'9. Conclusion\n'
'Psoriasis is a chronic autoimmune condition that affects millions of people worldwide.\n'
'While it cannot be cured, there are effective treatments that can help control symptoms and improve the quality of life for sufferers.'
,
'Dermatitis':
'A Comprehensive Overview:\n\n'
'Dermatitis is a general term for inflammation of the skin, often characterized by redness, swelling, and irritation.\n'
'It can have various triggers, including allergies, irritants, and genetics.\n\n'
'What Is Dermatitis?\n'
'Dermatitis refers to inflammation of the skin, causing redness, swelling, itching, and discomfort.\n'
'It can occur as a result of direct contact with irritants or allergens, but it can also be genetic or triggered by environmental factors.\n\n'

'Signs and Symptoms of Dermatitis:\n'
'Red, itchy rash\n'
'Dry, cracked skin\n'
'Swelling or blistering (in severe cases)\n'
'Burning or stinging sensation\n'
'Thickened skin in chronic cases\n'
'Scaling or peeling \n\n'
'Types of Dermatitis\n'
'Atopic Dermatitis (Eczema): A chronic skin condition causing dry, itchy, and inflamed skin. Common in children, but it can affect adults too.\n'
'Contact Dermatitis: Caused by direct contact with irritants or allergens, such as certain chemicals or plants like poison ivy.\n'
'Seborrheic Dermatitis: Characterized by flaky, oily patches on the scalp and other areas rich in oil glands, such as the face.\n'
'Nummular Dermatitis: Round, coin-shaped spots on the skin, often triggered by dry or damaged skin.\n\n'
'Methods of Treatment\n'
'Topical corticosteroids: These are anti-inflammatory medications applied to the skin to reduce inflammation and itching.\n'
'Moisturizers: Used to hydrate dry skin and prevent flare-ups.\n'
'Antihistamines: Taken orally to relieve itching and inflammation.\n'
'Avoiding triggers: Identifying and avoiding allergens or irritants can help prevent dermatitis.\n'
'Immunosuppressants: For severe cases, medications that suppress the immune system may be prescribed.\n\n'
'Preventive Measures\n'
'Moisturize regularly: Keeping the skin hydrated can prevent dryness and flare-ups.\n'
'Avoid known irritants: Stay away from chemicals or allergens that trigger symptoms.\n'
'Use gentle, fragrance-free products: Opt for mild soaps, shampoos, and detergents.\n'
'Wear gloves when handling chemicals: This can help prevent contact dermatitis.\n'
'Reduce stress: Managing stress can help prevent exacerbation of dermatitis.\n\n'
'Effects of Dermatitis:\n'
'Without treatment, dermatitis can lead to:\n'

'Severe itching and discomfort\n'
'Skin infections due to scratching\n'
'Sleep disturbances\n'
'Thickening of the skin over time (lichenification)Conclusion\n'
'Dermatitis is a common condition that can be managed with the right treatments and preventive measures.\n'
' Identifying triggers and maintaining a proper skincare routine are key to minimizing flare-ups.',
'Rosacea':
'A Comprehensive Overview:\n'
'Rosacea is a chronic skin condition that primarily affects the face, causing redness, visible blood vessels, and sometimes small, pus-filled bumps.\n\n'
'What Is Rosacea?\n'
'Rosacea is a long-term inflammatory skin condition, often mistaken for acne. \n'
'It typically affects the central part of the face, especially the nose and cheeks, and can worsen over time if left untreated.\n\n'

'Signs and Symptoms of Rosacea:\n'
'Facial redness (flushing)\n'
'Visible blood vessels (telangiectasia)\n'
'Swollen, red bumps\n'
'Eye irritation (ocular rosacea)\n'
'Thickened skin, especially around the nose\n'
'Burning or stinging sensation\n\n'
'Causes of Rosacea\n'
'While the exact cause of rosacea is unknown, several factors can trigger or worsen the condition:\n'

'Genetics: Family history plays a role.\n'
'Immune system response: Abnormal responses to certain bacteria (such as Demodex mites) may trigger inflammation.\n'
'Environmental factors: Exposure to sunlight, extreme temperatures, and wind can exacerbate symptoms.\n'
'Diet: Spicy foods, alcohol, and caffeine are known triggers\n'
'Stress: Emotional stress can worsen the condition.\n\n'
'Types of Rosacea:\n'
'Erythematotelangiectatic Rosacea: Characterized by facial redness, flushing, and visible blood vessels.\n'
'Papulopustular Rosacea: Includes redness along with acne-like breakouts.\n'
'Phymatous Rosacea: Causes skin thickening and enlargement, often around the nose.\n'
'Ocular Rosacea: Affects the eyes, causing redness, irritation, and swollen eyelids. \n\n'
'Methods of Treatment\n'
'Topical medications: These can reduce inflammation and redness.\n\n'
'Commonly used medications include:\n'
' metronidazole and azelaic acid.\n'
'Oral antibiotics: Tetracycline antibiotics, such as doxycycline, are used for more severe cases.\n'
'Laser therapy: Laser treatments can reduce visible blood vessels.\n'
'Lifestyle changes: Avoiding known triggers such as sunlight, alcohol, and spicy foods can prevent flare-ups.\n\n'
'Preventive Measures:\n'
'Sun protection: Use sunscreen regularly and wear protective clothing.\n'
'Avoid harsh skincare products: Use gentle, fragrance-free products on the skin.\n'
'Limit exposure to triggers: Identify foods, environmental factors, or emotions that exacerbate symptoms.\n'
'Maintain a healthy diet: Reducing spicy and alcohol-rich foods may help.\n'
'Manage stress: Stress reduction techniques like meditation or yoga may help reduce flare-ups.Effects of Rosacea\n'
'Without proper treatment, rosacea can lead to:\n'

'Chronic redness and irritation\n'
'Skin thickening (especially around the nose)\n'
'Eye complications\n'
'Emotional distress and low self-esteem Conclusion\n'
'Rosacea is a manageable condition, but it requires ongoing care and lifestyle adjustments.\n'
' Early diagnosis and treatment are crucial to prevent worsening symptoms.'
,
'Vitiligo':
'A Comprehensive Overview\n'
'Vitiligo is a condition in which the skin loses its pigment cells (melanocytes), resulting in white patches on various parts of the body.\n\n'

'What Is Vitiligo?\n'
'Vitiligo occurs when melanocytes, the cells that produce pigment in the skin, are destroyed.\n'
'This leads to patches of depigmented (white) skin on different parts of the body.\n\n'
'Signs and Symptoms of Vitiligo:\n'
'White patches on the skin (commonly on the face, hands, and feet)\n'
'Loss of pigment in the hair, eyebrows, or eyelashes\n'
'Change in color of the retina (inside of the eye)\n'
'Depigmentation in the mucous membranes (inside the mouth or nose)\n\n'
'Causes of Vitiligo\n'
'The exact cause of vitiligo is not known, but several factors may contribute:\n'

'Autoimmune response: The immune system mistakenly attacks melanocytes.\n'
'Genetics: A family history of vitiligo increases the risk.\n'
'Environmental factors: Sunburns, stress, or exposure to certain chemicals may trigger vitiligo.\n\n'
'Causes of Vitiligo\n'
'The exact cause of vitiligo is not known, but several factors may contribute:\n'

'Autoimmune response: The immune system mistakenly attacks melanocytes.\n'
'Genetics: A family history of vitiligo increases the risk.\n'
'Environmental factors: Sunburns, stress, or exposure to certain chemicals may trigger vitiligo.Methods of Treatment\n'
'Topical corticosteroids: Can help to restore pigment in some cases.\n'
'Phototherapy: Light therapy using ultraviolet (UV) light can stimulate melanocytes to produce pigment.\n'
'Skin grafting: In severe cases, healthy skin may be transplanted to depigmented areas.\n'
'Depigmentation therapy: In extensive cases, the remaining pigmented skin can be lightened to match the white patches.Preventive Measures\n\n'
'While there is no way to prevent vitiligo, people with the condition can:\n'

'Use sunscreen: Protecting the skin from the sun prevents burns and minimizes contrast between affected and unaffected areas.\n'
'Avoid skin trauma: Injuries, burns, or cuts can sometimes trigger new patches of vitiligo.\n'
'Handle stress: Since stress can worsen vitiligo, managing stress levels may be beneficial.Effects of Vitiligo\n\n'
'Vitiligo is not life-threatening but can cause:\n'

'Emotional distress\n'
'Low self-esteem\n'
'Social anxiety due to the visibility of the conditionConclusion\n'
'Vitiligo is a lifelong condition that can have emotional and psychological impacts. While treatment may not cure the condition, it can help improve the appearance of the skin and the individuals quality of life.',

'Hives(urticaria)':
'A Comprehensive Overview:\n'
'Hives are red, itchy, raised welts that appear on the skin due to an allergic reaction or other factors.\n\n'
'What Are Hives?\n'
'Hives (urticaria) are raised, itchy welts that can appear anywhere on the body.\n'
' They are usually the result of an allergic reaction but can also be caused by infections, stress, or other triggers.\n\n'

'Signs and Symptoms of Hives\n'
'Raised, red, itchy welts\n'
'Welts that change size or shape\n'
'Swelling in the affected areas\n'
'Welts that appear and disappear suddenlyCauses of Hives\n'
'Allergies: Foods, medications, insect stings, or latex are common triggers.\n'
'Infections: Viral or bacterial infections can cause hives.\n'
'Stress: Emotional stress can trigger or worsen hives.\n'
'Temperature changes: Exposure to extreme cold or heat can cause hives.\n'
'Physical triggers: Pressure on the skin, sun exposure, or exercise can also be factors.\n\n'
'Types of Hives\n'
'Acute Urticaria: Lasts for less than six weeks, typically caused by food, drugs, or infections.\n'
'Chronic Urticaria: Lasts for more than six weeks and may have unknown causes.\n'
'Physical Urticaria: Triggered by physical factors such as heat, cold, or pressure.\n\n'
'Methods of Treatment\n'
'Antihistamines: These medications help relieve itching and reduce swelling.\n'
'Corticosteroids: In severe cases, corticosteroids may be prescribed to reduce inflammation.\n'
'Avoiding triggers: Identifying and avoiding the allergen or trigger can prevent hives.\n'
'Epinephrine: For severe allergic reactions (anaphylaxis), an epinephrine injection may be required.\n\n'
'Preventive Measures\n'
'Avoid allergens: Identifying and steering clear of known allergens is the best prevention.\n'
'Manage stress: Stress management techniques can reduce the risk of hives.\n'
'Use mild skincare products: Avoiding harsh soaps or detergents can help prevent flare-ups.Effects of Hives\n'
'Hives are generally not dangerous but can cause discomfort and emotional distress.\n'
'Severe allergic reactions associated with hives may lead to:\n'

'Breathing difficulties\n'
'Swelling of the throat\n'
'Anaphylactic shockConclusion\n'
'Hives are typically a temporary condition, but chronic cases require ongoing management.\n' 
'Identifying and avoiding triggers is key to preventing flare-ups.'
,
    // Add more details as needed
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dermatology Diseases'),
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
              style: TextStyle(fontSize: 18),
            ),
            Divider(thickness: 1),
          ],
        ),
      ),
    );
  }
}
