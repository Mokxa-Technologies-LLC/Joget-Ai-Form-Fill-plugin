# AI Form Fill Plugin (Joget)

## Introduction

The **AI Form Fill Plugin** extends Joget’s AI capabilities by allowing forms to be automatically populated using **artificial intelligence**. Users can fill forms using **natural language prompts, voice input, or uploaded files**, significantly reducing manual data entry.

The plugin is implemented as a **form element**, making it easy to use through drag-and-drop configuration without writing custom code.

---

## Key Features

* Auto-fill Joget form fields using text-based prompts
* Support for **audio input** (speech-to-text form filling)
* Extract and map data from uploaded files
* Supported file types: PNG/JPG (including handwritten text), TXT, PDF, DOCX
* Simple drag-and-drop form element
* Configurable AI model (e.g., GPT-4o)
* Secure API access using proxy domain and API key
* Improves data accuracy and reduces form completion time

---

## Prerequisites

* Joget **Enterprise Edition**
* Developer access to Joget App Center
* Valid AI service **API Key**
* Internet access to the AI service endpoint

---

## Installation

1. Log in to **Joget App Center**.
2. Navigate to **Settings → Manage Plugins**.
3. Click **Upload Plugin**.
4. Upload the **AI Form Fill Plugin JAR** file.
5. Confirm the plugin appears under **Installed Plugins**.

---

## Usage

### Add Plugin to Form

1. Open **Form Builder**.
2. Drag **AI Form Fill** element into the form.
3. Open the element configuration.

### Basic Configuration

* **Label** – Display name shown to users (e.g., *AI Form Fill*)
* **ID** – Internal form field identifier (e.g., *field1*)

### AI Configuration

* **Model** – AI model to be used (e.g., *gpt-4o*)
* **Proxy Domain** – API endpoint (default: [https://api.openai.com/v1/](https://api.openai.com/v1/))
* **API Key** – Authentication key for AI service (required)

---

## Supported Input Methods

* **Text Prompt** – Enter instructions to fill form fields
* **Audio Prompt** – Speak input; audio is transcribed and processed
* **File Upload** – Upload documents or images for data extraction

---

## How It Works

1. User provides input via text, audio, or file upload.
2. The AI model processes the input and extracts structured data.
3. Extracted values are mapped and populated into Joget form fields.

---

## Use Cases

* Filling forms from scanned or handwritten documents
* Voice-based data entry
* Converting PDFs or Word documents into structured form data
* Reducing manual data entry in enterprise workflows

---

## Best Practices

* Secure API keys using **App Variables**
* Provide clear prompts for better accuracy
* Use structured forms for optimal AI mapping
* Restrict access using Joget role-based permissions

---

## License & Support

This plugin is intended for enterprise Joget deployments.
For support, enhancements, or issues, please contact the plugin provider or maintainers.

---

## Conclusion

The AI Form Fill Plugin enhances Joget applications with AI-powered form automation, enabling faster, smarter, and more accurate data capture using modern AI technologies.
