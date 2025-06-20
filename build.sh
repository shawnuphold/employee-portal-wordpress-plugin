#!/bin/bash
# Netlify build script for Employee Portal Plugin

echo "🚀 Building Employee Portal Plugin for WordPress..."

# Create build directory
mkdir -p dist

# Create plugin directory structure
mkdir -p dist/employee-portal

echo "📁 Copying plugin files..."

# Copy all necessary files to the plugin directory
cp employee-portal.php dist/employee-portal/
cp readme.txt dist/employee-portal/
cp -r includes dist/employee-portal/
cp -r admin dist/employee-portal/
cp -r public dist/employee-portal/
cp -r templates dist/employee-portal/

# Copy license and other files if they exist
[ -f LICENSE ] && cp LICENSE dist/employee-portal/
[ -f CHANGELOG.md ] && cp CHANGELOG.md dist/employee-portal/

echo "🧹 Cleaning up unnecessary files..."

cd dist/employee-portal

# Remove development files
find . -name "*.md" -not -name "CHANGELOG.md" -delete
find . -name ".git*" -delete
find . -name "*.yml" -delete
find . -name "build.sh" -delete
find . -name "netlify.toml" -delete
find . -name ".DS_Store" -delete
find . -name "Thumbs.db" -delete

cd ../..

echo "📦 Creating plugin ZIP file..."

# Create ZIP file
cd dist
zip -r employee-portal.zip employee-portal/
cd ..

# Copy ZIP to root for easy download
cp dist/employee-portal.zip ./employee-portal-latest.zip

echo "✅ Plugin built successfully!"
echo "📁 Files created:"
echo "   - dist/employee-portal/ (plugin folder)"
echo "   - dist/employee-portal.zip (installable ZIP)"
echo "   - employee-portal-latest.zip (download link)"

# Create a simple HTML page for downloads
cat > dist/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Portal WordPress Plugin</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            max-width: 800px;
            margin: 0 auto;
            padding: 40px 20px;
            line-height: 1.6;
        }
        .hero {
            text-align: center;
            padding: 60px 20px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border-radius: 12px;
            margin-bottom: 40px;
        }
        .download-btn {
            display: inline-block;
            background: #00a32a;
            color: white;
            padding: 15px 30px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 600;
            margin: 10px;
            transition: all 0.3s ease;
        }
        .download-btn:hover {
            background: #008a20;
            transform: translateY(-2px);
        }
        .features {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin: 40px 0;
        }
        .feature {
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }
        .instructions {
            background: #f8f9fa;
            padding: 30px;
            border-radius: 8px;
            margin: 40px 0;
        }
        .step {
            margin: 15px 0;
            padding-left: 30px;
            position: relative;
        }
        .step::before {
            content: counter(step-counter);
            counter-increment: step-counter;
            position: absolute;
            left: 0;
            top: 0;
            background: #667eea;
            color: white;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 12px;
            font-weight: bold;
        }
        .instructions ol {
            counter-reset: step-counter;
            list-style: none;
            padding: 0;
        }
    </style>
</head>
<body>
    <div class="hero">
        <h1>Employee Portal WordPress Plugin</h1>
        <p>Complete HR management system for WordPress with secure document handling, time-off requests, and role-based dashboards.</p>
        <a href="employee-portal.zip" class="download-btn" download>📦 Download Plugin ZIP</a>
        <a href="https://github.com/yourusername/employee-portal" class="download-btn">🔗 View on GitHub</a>
    </div>

    <div class="features">
        <div class="feature">
            <h3>🏢 Employee Management</h3>
            <p>Complete employee profiles, departments, and organizational structure management.</p>
        </div>
        <div class="feature">
            <h3>📄 Document Management</h3>
            <p>Secure upload and download of W-2s, I-9s, pay stubs, and company policies.</p>
        </div>
        <div class="feature">
            <h3>🏖️ Time-Off Requests</h3>
            <p>Employee self-service time-off request system with approval workflow.</p>
        </div>
        <div class="feature">
            <h3>📢 Announcements</h3>
            <p>Company-wide announcements and important notifications system.</p>
        </div>
    </div>

    <div class="instructions">
        <h2>📋 Installation Instructions</h2>
        <ol>
            <li class="step">Download the <code>employee-portal.zip</code> file above</li>
            <li class="step">Go to your WordPress Admin → Plugins → Add New</li>
            <li class="step">Click "Upload Plugin" and choose the ZIP file</li>
            <li class="step">Click "Install Now" and then "Activate Plugin"</li>
            <li class="step">Click "Auto Setup Now" when prompted</li>
            <li class="step">Start adding employees and managing your HR processes!</li>
        </ol>
    </div>

    <div class="instructions">
        <h2>🚀 Quick Start</h2>
        <p>After activation:</p>
        <ol>
            <li class="step">Go to <strong>Employee Portal</strong> in your WordPress admin menu</li>
            <li class="step">Click <strong>"Add New Employee"</strong> to add your first employee</li>
            <li class="step">Upload documents in <strong>"Documents"</strong> section</li>
            <li class="step">Create announcements in <strong>"Announcements"</strong> section</li>
            <li class="step">Employees can login at <code>/employee-login/</code> page</li>
        </ol>
    </div>

    <footer style="text-align: center; margin-top: 60px; padding-top: 20px; border-top: 1px solid #ddd;">
        <p>Built with ❤️ for WordPress • <a href="https://github.com/yourusername/employee-portal">View Source Code</a></p>
    </footer>
</body>
</html>
EOF

echo "🌐 Created download page: dist/index.html"
echo "🎉 Build completed successfully!"
