# Ree-See.it

# Inspiration
"Ree-See-It" is driven by the urgent need to reduce environmental waste and promote healthier lifestyles. With the environmental and health impacts of paper receipts becoming increasingly evident, our app offers a sustainable and health-conscious alternative for receipt management.

# What It Does
"Ree-See-It" is a comprehensive digital receipt management and expense tracking solution. Its key features include:

- Digital Receipt Storage: Transforms paper receipts into a digital format, significantly reducing environmental waste.
- Expense Categorization: Allows users to effectively organize their expenses, promoting better financial management.
- Health Risk Mitigation: Minimizes exposure to harmful chemicals commonly found in paper receipts, such as BPA and BPS.
- Accessibility for the Visually Impaired: Integrates assistive technologies, ensuring the app is accessible to all users.
- Online Purchase Management: Streamlines the process of tracking online shopping expenses.
- Shared Expense Feature: Simplifies the splitting of costs among groups.

# How We Built It 
- "Ree-See-It" is developed as an iOS mobile application using Swift and SwiftUI. It features:
- Microservice Architecture: Incorporates components like image processing (extract all the parsed string from the receipt), AWS S3 cloud storage (storing receipt images on the cloud in case users want to keep them for future and business management) , ChatGPT API (convert the parsed string to JSON), geolocation services (forward geocoding), and MongoDB for data storage.
- Optical Character Recognition: Utilizes Tesseract.js for accurate OCR.
- User Authentication: Implements comprehensive authentication using Auth0.


# Challenges We Ran Into

- Frontend Issues: Navigational bugs and image exporting challenges.
- Backend Complexities: Difficulties with API integration and Docker compatibility (dependencies hell).
- Database Management: Overcoming inconsistencies in MongoDB documents.

# Accomplishments We're Proud Of Our team achieved:

- Innovative Solution: An app that significantly contributes to resolving environmental and health concerns.
- Effective Teamwork: Demonstrable excellence in collaboration and problem-solving.

# What We Learned:

- Advanced Technology: Mastery of Swift, SwiftUI, and various backend technologies.
- Team Collaboration: Improved teamwork skills in demanding scenarios.

# What's Next:

- Expand Features: Add more user customization options and advanced analytics.
- Improve Scalability: Upgrade the backend for enhanced performance.
- Market Deployment: Gear up for a broader market release.
"Ree-See-It" is not just an app; it's a step towards a more sustainable and health-conscious future. Join us in making a difference!
