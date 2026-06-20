$baseContent = Get-Content -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\sevivedetel.html" -Raw

# 1. Prepare the Master Template
# Fix Title
$baseContent = $baseContent -replace '(?s)<h1([^>]*)>Flexible design pricing</h1>', '<h1$1>{{SERVICE_TITLE}}</h1>'
$baseContent = $baseContent -replace '(?s)<p([^>]*)>Strategic architectural insights drive sustainable growth by blending innovation, functionality, and environmental responsibility\. Thoughtful design solutions\.</p>', '<p$1>{{SERVICE_DESC}}</p>'

# Remove the logo above title if necessary, or just leave it. The user might want the logo there.

# Redesign Cards section into Content Area
$contentBlock = @"
<div class="w-layout-vflex rt-pricing-card-v2 rt-overflow-hidden" style="width: 100%; max-width: 1000px; margin: 0 auto; padding: 40px; background-color: #fff; border-radius: 20px;">
    <div class="rt-text-style-h4" style="margin-bottom: 20px;">Why Choose Our Services?</div>
    <div class="rt-text-color-cloud-gray" style="margin-bottom: 40px;">{{WHY_CHOOSE_LIST}}</div>
    
    <div class="rt-text-style-h4" style="margin-bottom: 20px;">Service Features</div>
    <div class="rt-text-color-cloud-gray" style="margin-bottom: 40px;">
        <ul style="padding-left: 20px;">{{FEATURES_LIST}}</ul>
    </div>
    
    <div class="rt-text-style-h4" style="margin-bottom: 20px;">Sectors We Serve</div>
    <div class="rt-text-color-cloud-gray" style="margin-bottom: 40px;">
        <ul style="padding-left: 20px;">{{SECTORS_LIST}}</ul>
    </div>
    
    <div class="rt-text-style-h4" style="margin-bottom: 20px;">Featured Projects</div>
    <div class="rt-text-color-cloud-gray" style="margin-bottom: 20px;">
        <ul style="padding-left: 20px;">{{PROJECTS_LIST}}</ul>
    </div>
</div>
"@

$baseContent = $baseContent -replace '(?s)<div class="rt-pricing-cards-grid-v2">.*?</div>\s*</div>\s*</section>', "<div class=`"rt-pricing-cards-grid-v2`" style=`"grid-template-columns: 1fr;`">`n$contentBlock`n</div>`n</div>`n</section>"

# FAQ Section -> Process Section
$baseContent = $baseContent -replace 'Questions &amp; answers', 'Our Process'
$baseContent = $baseContent -replace 'Find answers to common questions about our architectural design services, pricing, and project process\.', 'We follow a structured, transparent process to ensure your project succeeds.'

# Replace the 5 FAQ questions and answers with placeholders
$baseContent = $baseContent -replace 'How long does a typical architectural project take\?', '{{P1_T}}'
$baseContent = $baseContent -replace 'The timeline for a project depends on its scope and complexity.*?timelines during the consultation\.', '{{P1_D}}'

$baseContent = $baseContent -replace 'Do you handle the permit process\?', '{{P2_T}}'
$baseContent = $baseContent -replace 'Yes, we handle all necessary paperwork and permit applications.*?comply with local building codes\.', '{{P2_D}}'

$baseContent = $baseContent -replace 'Can I request changes during the design phase\?', '{{P3_T}}'
$baseContent = $baseContent -replace 'Absolutely\. We encourage client involvement and provide multiple rounds of revisions during the concept and design development phases to ensure the final result aligns with your vision\.', '{{P3_D}}'

$baseContent = $baseContent -replace 'What is the difference between architecture and interior design\?', '{{P4_T}}'
$baseContent = $baseContent -replace 'Architecture focuses on the structural design, layout, and functionality of a building, while interior design focuses on interior spaces, materials, lighting, and aesthetics to enhance comfort and usability\.', '{{P4_D}}'

$baseContent = $baseContent -replace 'How do you collaborate with contractors during construction\?', '{{P5_T}}'
$baseContent = $baseContent -replace 'We maintain regular communication with contractors through site visits, design reviews, and progress meetings.*?quality and efficiency\.', '{{P5_D}}'

# Ensure the title tag is updated to the service name
$baseContent = $baseContent -replace '<title>Linoxa - Webflow HTML website template</title>', '<title>{{SERVICE_NAME}} - Elite Overseas Building Contracting</title>'

# Define Data
$services = @(
    @{
        Id = "turnkey"; File = "service-turnkey.html"; Name = "Turnkey Projects"; Title = "Turnkey Projects";
        Desc = "Our Turnkey Projects service provides a seamless, integrated approach to construction projects. From initial concept through design, planning, and construction to final handover, we manage every aspect of your project with precision and expertise.";
        Why = "<b>Single Point of Responsibility</b><br>One team manages design and construction, eliminating coordination issues and reducing project risks.<br><br><b>Cost Efficiency</b><br>Early cost certainty and value engineering throughout the design process optimize your budget.<br><br><b>Faster Delivery</b><br>Overlapping design and construction phases significantly reduce overall project timeline.<br><br><b>Enhanced Quality</b><br>Seamless collaboration between designers and builders ensures superior results.";
        Features = "<li>Architectural Design & Planning</li><li>3D Modeling & Visualization</li><li>Structural Engineering</li><li>Project Management</li><li>Quality Assurance & Control</li><li>Timely Delivery Guarantee</li><li>Post-Construction Support</li><li>Value Engineering</li>";
        Sectors = "<li>Residential</li><li>Commercial</li><li>Industrial</li><li>Hospitality</li><li>Healthcare</li>";
        Projects = "<li>Dubai Marina Residential Tower - 45-story luxury apartments</li><li>Business Bay Office Complex - Grade A commercial space</li><li>Al Ain Industrial Facility - State-of-the-art manufacturing</li>";
        P1T = "1. Initial Consultation"; P1D = "Understanding your vision, requirements, budget, and timeline.";
        P2T = "2. Concept Design"; P2D = "Creating preliminary designs and 3D visualizations for approval.";
        P3T = "3. Detailed Planning"; P3D = "Comprehensive technical drawings, specifications, and schedules.";
        P4T = "4. Construction Phase"; P4D = "Professional execution with regular updates and quality checks.";
        P5T = "5. Handover & Support"; P5D = "Final inspection, documentation, and post-completion support.";
    },
    @{
        Id = "civil"; File = "service-civil.html"; Name = "Civil Engineering"; Title = "Civil Engineering";
        Desc = "Elite's civil engineering services encompass all aspects of structural construction, from foundation design to complex infrastructure projects. Our experienced engineers deliver robust, durable solutions that stand the test of time.";
        Why = "<b>Expert Engineering</b><br>Licensed professional engineers with extensive UAE construction experience.<br><br><b>Advanced Technology</b><br>Latest surveying equipment and structural analysis software for precision.<br><br><b>Safety First</b><br>Rigorous safety protocols and compliance with UAE building codes.<br><br><b>Quality Materials</b><br>Premium construction materials from certified suppliers.";
        Features = "<li>Structural Engineering & Design</li><li>Foundation Systems</li><li>Site Preparation & Grading</li><li>Concrete Works</li><li>Road & Infrastructure Construction</li><li>Earthworks & Excavation</li><li>Soil Stabilization</li><li>Structural Testing</li>";
        Sectors = "<li>Infrastructure</li><li>Commercial</li><li>Residential</li><li>Industrial</li>";
        Projects = "<li>DIFC Office Tower - 35-story structural framework</li><li>Sheikh Zayed Road Infrastructure - Major road development</li><li>Al Ain Industrial Complex - Heavy-duty foundations</li>";
        P1T = "1. Site Investigation"; P1D = "Comprehensive soil testing and site assessment.";
        P2T = "2. Structural Design"; P2D = "Detailed engineering calculations and structural plans.";
        P3T = "3. Foundation Work"; P3D = "Excavation, reinforcement, and concrete pouring.";
        P4T = "4. Structural Construction"; P4D = "Building frames, columns, beams, and slabs.";
        P5T = "5. Quality Verification"; P5D = "Testing and certification of structural integrity.";
    },
    @{
        Id = "mep"; File = "service-mep.html"; Name = "MEP Services"; Title = "MEP Services";
        Desc = "Our MEP division delivers comprehensive mechanical, electrical, and plumbing installations. From HVAC systems to electrical networks and plumbing infrastructure, we ensure optimal performance, energy efficiency, and compliance with all regulations.";
        Why = "<b>Certified Engineers</b><br>Licensed MEP professionals with international certifications.<br><br><b>Energy Efficiency</b><br>Sustainable solutions that reduce operational costs and environmental impact.<br><br><b>Advanced Systems</b><br>Latest HVAC, electrical, and plumbing technologies for optimal performance.<br><br><b>24/7 Support</b><br>Comprehensive maintenance and emergency response services.";
        Features = "<li>HVAC System Design & Installation</li><li>Electrical Distribution Systems</li><li>Plumbing & Drainage Networks</li><li>Fire Safety & Suppression Systems</li><li>Building Automation & Controls</li><li>Energy Management Systems</li><li>Low Current Systems</li><li>Renewable Energy Integration</li>";
        Sectors = "<li>Commercial</li><li>Residential</li><li>Healthcare</li><li>Education</li><li>Hospitality</li>";
        Projects = "<li>Emirates Palace Extension - Luxury hotel MEP systems</li><li>Healthcare City Clinic - Medical-grade installations</li><li>Business Bay Tower - Smart building automation</li>";
        P1T = "1. System Design"; P1D = "Comprehensive MEP engineering and load calculations.";
        P2T = "2. Coordination"; P2D = "3D MEP coordination to avoid conflicts and optimize routing.";
        P3T = "3. Installation"; P3D = "Professional installation by certified technicians.";
        P4T = "4. Testing & Commissioning"; P4D = "Rigorous testing to ensure all systems operate correctly.";
        P5T = "5. Maintenance"; P5D = "Ongoing preventive maintenance and support.";
    },
    @{
        Id = "interior"; File = "service-interior.html"; Name = "Interior Fit-Out"; Title = "Interior Fit-Out";
        Desc = "Elite's interior fit-out services bring your vision to life with exceptional design and craftsmanship. We specialize in creating functional, aesthetically pleasing spaces that reflect your brand identity and meet your operational needs.";
        Why = "<b>Custom Design</b><br>Bespoke interior solutions tailored to your specific requirements.<br><br><b>Premium Materials</b><br>High-quality finishes and materials from leading suppliers.<br><br><b>Fast Track Options</b><br>Expedited fit-out programs with minimal disruption to operations.<br><br><b>Turnkey Delivery</b><br>Complete fit-out including furniture, fixtures, and equipment.";
        Features = "<li>Space Planning & Design</li><li>Partitioning & Ceilings</li><li>Flooring Solutions</li><li>Lighting Design & Installation</li><li>Custom Furniture & Joinery</li><li>Wall Finishes & Decorative Elements</li><li>Audio-Visual Integration</li><li>Brand Identity Implementation</li>";
        Sectors = "<li>Office</li><li>Retail</li><li>Residential</li><li>Hospitality</li><li>Healthcare</li>";
        Projects = "<li>DIFC Office Floors - Premium Grade A fit-out</li><li>Dubai Mall Retail Outlets - High-end retail spaces</li><li>Luxury Residential Units - bespoke apartment interiors</li>";
        P1T = "1. Space Planning"; P1D = "Optimizing layout and flow for functionality and aesthetics.";
        P2T = "2. Design Development"; P2D = "Detailed interior design with material selections and 3D renders.";
        P3T = "3. Technical Execution"; P3D = "Partition walls, ceilings, flooring, and lighting installation.";
        P4T = "4. Finishing Touches"; P4D = "Custom joinery, furniture installation, and decorative elements.";
        P5T = "5. Final Handover"; P5D = "Complete cleaning, snagging, and project documentation.";
    },
    @{
        Id = "steel"; File = "service-steel.html"; Name = "Steel & Structural Works"; Title = "Steel & Structural Works";
        Desc = "Our steel fabrication and structural engineering services provide the backbone for your construction projects. With state-of-the-art facilities and expert craftsmen, we deliver precision-engineered steel solutions for projects of all scales.";
        Why = "<b>Modern Facilities</b><br>Advanced fabrication workshop with CNC cutting and welding equipment.<br><br><b>Quality Assurance</b><br>Rigorous testing and inspection at every stage of fabrication.<br><br><b>Expert Team</b><br>Certified welders and structural engineers with international experience.<br><br><b>On-Time Delivery</b><br>Efficient production schedules ensuring timely project completion.";
        Features = "<li>Steel Structure Design & Engineering</li><li>Fabrication & Welding</li><li>Structural Steel Frames</li><li>Mezzanine Floors</li><li>Metal Roofing & Cladding</li><li>Industrial Structures</li><li>Quality Control & Testing</li><li>Anti-Corrosion Treatment</li>";
        Sectors = "<li>Industrial</li><li>Commercial</li><li>Infrastructure</li><li>Warehouses</li>";
        Projects = "<li>Al Ain Industrial Facility - Heavy steel framework</li><li>Dubai Logistics Hub - Warehouse steel structures</li><li>Commercial Tower - Structural steel components</li>";
        P1T = "1. Structural Design"; P1D = "Detailed engineering calculations and structural drawings.";
        P2T = "2. Material Procurement"; P2D = "Sourcing premium quality steel from certified suppliers.";
        P3T = "3. Fabrication"; P3D = "Precision cutting, drilling, and welding in our workshop.";
        P4T = "4. Surface Treatment"; P4D = "Sandblasting and protective coatings for durability.";
        P5T = "5. Erection & Installation"; P5D = "Professional site installation with safety measures.";
    },
    @{
        Id = "infrastructure"; File = "service-infrastructure.html"; Name = "Infrastructure Development"; Title = "Infrastructure Development";
        Desc = "Elite's infrastructure development services encompass large-scale projects including roads, utilities, drainage systems, and public facilities. We combine engineering excellence with sustainable practices to create infrastructure that serves communities for generations.";
        Why = "<b>Large-Scale Capability</b><br>Resources and expertise to handle major infrastructure projects.<br><br><b>Regulatory Compliance</b><br>Full compliance with Dubai Municipality and RTA standards.<br><br><b>Sustainable Solutions</b><br>Eco-friendly infrastructure design and construction practices.<br><br><b>Community Focus</b><br>Minimizing disruption while delivering essential infrastructure.";
        Features = "<li>Road Construction & Asphalt Works</li><li>Utility Networks (Water, Sewer, Electricity)</li><li>Drainage Systems</li><li>Public Facilities Development</li><li>Site Development & Earthworks</li><li>Traffic Management Systems</li><li>Street Lighting</li><li>Landscaping & Public Spaces</li>";
        Sectors = "<li>Government</li><li>Municipal</li><li>Private Development</li><li>Community Projects</li>";
        Projects = "<li>Dubai Marina Infrastructure - Complete utility networks</li><li>Sheikh Zayed Road Development - Major highway works</li><li>Community Park - Public facility with utilities</li>";
        P1T = "1. Master Planning"; P1D = "Comprehensive infrastructure planning and route optimization.";
        P2T = "2. Approvals & Permits"; P2D = "Securing all necessary approvals from relevant authorities.";
        P3T = "3. Site Preparation"; P3D = "Clearing, excavation, and ground preparation works.";
        P4T = "4. Construction"; P4D = "Road laying, utility installation, and civil works.";
        P5T = "5. Testing & Handover"; P5D = "Quality testing and official project handover.";
    }
)

foreach ($s in $services) {
    $out = $baseContent
    $out = $out -replace '\{\{SERVICE_NAME\}\}', $s.Name
    $out = $out -replace '\{\{SERVICE_TITLE\}\}', $s.Title
    $out = $out -replace '\{\{SERVICE_DESC\}\}', $s.Desc
    $out = $out -replace '\{\{WHY_CHOOSE_LIST\}\}', $s.Why
    $out = $out -replace '\{\{FEATURES_LIST\}\}', $s.Features
    $out = $out -replace '\{\{SECTORS_LIST\}\}', $s.Sectors
    $out = $out -replace '\{\{PROJECTS_LIST\}\}', $s.Projects
    $out = $out -replace '\{\{P1_T\}\}', $s.P1T
    $out = $out -replace '\{\{P1_D\}\}', $s.P1D
    $out = $out -replace '\{\{P2_T\}\}', $s.P2T
    $out = $out -replace '\{\{P2_D\}\}', $s.P2D
    $out = $out -replace '\{\{P3_T\}\}', $s.P3T
    $out = $out -replace '\{\{P3_D\}\}', $s.P3D
    $out = $out -replace '\{\{P4_T\}\}', $s.P4T
    $out = $out -replace '\{\{P4_D\}\}', $s.P4D
    $out = $out -replace '\{\{P5_T\}\}', $s.P5T
    $out = $out -replace '\{\{P5_D\}\}', $s.P5D
    
    [IO.File]::WriteAllText("c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\$($s.File)", $out, [System.Text.Encoding]::UTF8)
    Write-Output "Generated $($s.File)"
}