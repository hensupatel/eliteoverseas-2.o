$content = Get-Content -Path "c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\service.html" -Raw

# 1. Update Hero
$content = $content -replace "Built for sustainable spaces", "Elite Overseas"
$content = $content -replace "Focused on meaningful spaces", "Comprehensive Construction Services"
$content = $content -replace "We combine creative design and compelling storytelling to craft memorable brand experiences that engage audiences, inspire loyalty, and leave a lasting impact across all touchpoints.", "Elite Overseas Building Contracting delivers end-to-end construction solutions across diverse sectors with expertise, precision, and unwavering commitment to quality."

# 2. Update About / Why Choose
$content = $content -replace "Designing spaces with purpose and precision", "Why Choose Elite for Your Project?"
$content = $content -replace "95%", "25+"
$content = $content -replace "Customer\s*satisfaction rate", "Years of successful project delivery"
$content = $content -replace "Sustainable creativity, timeless appeal\.", "Proven track record across Dubai and the UAE."

$content = $content -replace "Modern\s*architecture", "Integrated Solutions"
$content = $content -replace "Modern\s*spaces built with clarity, function, and lasting design value\.", "From design to completion, we handle every aspect of your construction project."

$content = $content -replace "Building\s*renovation", "Expert Craftsmanship"
$content = $content -replace "Thoughtful design focused on structure, balance, and efficiency\.", "Our skilled professionals deliver precision and quality in every detail."

# 3. Duplicate overview-v6 for the 6 specialized services
$pattern = '(?s)<div data-wf--rt-overview--variant="overview-v2"[^>]*>.*?<section class="rt-overview-v6">.*?</section>\s*</div>'
$match = [regex]::Match($content, $pattern)
if ($match.Success) {
    $v6_block = $match.Value
    
    # Generate Block 1
    $block1 = $v6_block
    $block1 = $block1 -replace "Interior design", "Building Renovation"
    $block1 = $block1 -replace "Thoughtfully designed spaces reflecting identity and\s*functionality\.", "Professional building renovation & refurbishment services with attention to detail."
    $block1 = $block1 -replace "Consultation", "Facade Engineering"
    $block1 = $block1 -replace "We transform ideas into inspiring architectural spaces\s*with clarity, purpose, and style\.", "Professional facade engineering & cladding services with attention to detail."
    $block1 = $block1 -replace "3D Modeling", "Waterproofing Solutions"
    $block1 = $block1 -replace "Architecture focused on simplicity, balance, and creating\s*lasting impressions through design\.", "Professional waterproofing solutions services with attention to detail."
    
    # Generate Block 2
    $block2 = $v6_block
    $block2 = $block2 -replace "Building documentation", "Additional Services"
    $block2 = $block2 -replace "Designing sustainable, modern structures that balance aesthetics, purpose, and human\s*experience\.", "Additional specialized services to meet your unique construction requirements."
    $block2 = $block2 -replace "Interior design", "Landscaping & Hardscaping"
    $block2 = $block2 -replace "Thoughtfully designed spaces reflecting identity and\s*functionality\.", "Professional landscaping & hardscaping services with attention to detail."
    $block2 = $block2 -replace "Consultation", "Project Consulting"
    $block2 = $block2 -replace "We transform ideas into inspiring architectural spaces\s*with clarity, purpose, and style\.", "Professional project consulting services with attention to detail."
    $block2 = $block2 -replace "3D Modeling", "Maintenance Services"
    $block2 = $block2 -replace "Architecture focused on simplicity, balance, and creating\s*lasting impressions through design\.", "Professional maintenance services services with attention to detail."
    
    $content = $content -replace [regex]::Escape($v6_block), "$block1`n$block2"
}

# 4. Clean up sticky sliders links to #
$content = $content -replace 'href="about.html"([^>]*)class="rt-overview-main-item"', 'href="#"$1class="rt-overview-main-item"'
$content = $content -replace 'href="/pricing-one"([^>]*)class="rt-service-button w-inline-block"', 'href="#"$1class="rt-service-button w-inline-block"'

[IO.File]::WriteAllText("c:\Users\Hensu patel\Desktop\eliteoverseas-2.o\service.html", $content, [System.Text.Encoding]::UTF8)