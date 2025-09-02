# Screenshot Sorter

A smart tool to automatically organize and declutter your desktop screenshots using AI. Keep what matters, delete what doesn't.

## Why This Exists

We take screenshots constantly on Mac - payment confirmations, useful information from podcasts or meetings, coding references, or just capturing moments. They all pile up on your desktop, creating visual clutter and making it hard to find what you actually need.

This tool helps you:
- **Save time** by letting AI decide what's worth keeping
- **Preserve important screenshots** while removing clutter
- **Clean your desktop** without manual effort

## What It Does

The AI analyzes each screenshot and organizes them automatically:

1. **Scans** your chosen folder for images
2. **Analyzes** content and importance using AI
3. **Categorizes** the screenshot into various types to help you review easily
3. **Organizes** into "keep" or "delete" folders
4. **Cleans** your desktop by moving processed files

Perfect for:
- 📱 Payment confirmations and receipts
- 📚 Educational content from presentations
- 💻 Code snippets and technical references
- 🎥 Meeting notes and important information

## How It Works (Technical Details)

This project uses n8n (a workflow automation platform) running locally on your Mac via Docker. The AI-powered workflow:

1. **Setup**: Installs required tools (Docker, Node.js, pnpm) and starts n8n
2. **Import**: You import the pre-built workflow JSON file into n8n
3. **Configure**: Set your screenshot folder path and OpenAI API key
4. **Run**: Execute the workflow through n8n's web interface

## Requirements
- macOS
- Git
- Terminal access
- OpenAI API Key

## Quick Start

### First Time Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/kanupriya1293/screenshot_sorter.git
   cd screenshot_sorter
   ```

2. **Configure your settings**
   Edit `config.env` and update the path to your screenshot folder:
   ```
   SCREENSHOT_PATH=/path/to/your/screenshots
   ```

3. **Run the setup script**
   ```bash
   ./setup.sh
   ```
   This will install all required dependencies and start n8n automatically.

   Once setup is complete, you can start and stop n8n as needed:
   ```bash
   # If Docker is not running, run setup again
   ./setup.sh

   # Or just restart n8n (if Docker is already running)
   pnpm stop
   pnpm start

   # View logs (if something goes wrong)
   pnpm logs
   ```

### Run the Workflow in n8n

1. **Access n8n**
   Open your browser and go to: http://localhost:5678 to access n8n.

2. **Import the JSON Workflow**
   In n8n, click on Create Workflow on top right. It will open a blank project.
      - Click on the three dots (elipsis) on top right corner.
      - Select "Import from file" from the dropdown
      - Select the `screenshot_sorter.json` file from this repository.
   You will now see all the nodes in the workflow and their connections on the canvas.

3. **Add OpenAI Key**
   Notice the error indicator on 'Analyse image' node (find the node with OpenAI Icon). This is because n8n does not know which API key to use.
      - Double click on the 'Analyse image' node.
      - Click on the dropdown for 'Credential to connect with'.
      - If you do not already have one, click on 'Create New Credential'.
      - Paste your OpenAI API key in the API Key input box and hit 'Save'.
      - You should see a message 'Connection tested successfully'. Close the dialog box.
      - Go back to canvas and 'Save' the workflow.
   The workflow is now ready for execution.

4. **Execute the Workflow**
      - Hover cursor over the first node 'Trigger Screenshot Sorter'
      - Click on 'Execute workflow' button. This will run the workflow.
   If the workflow stops after processing a few images due to rate limiting, then pause for the duration recommended in the error message and 'Execute workflow' again.

5. **Review the Organised Screenshots**
   As the workflow progresses, you should find processed screenshots moved to folder called 'organised' and appropriately categorised in 'keep' or 'delete' folders.
   Feel free to review them and delete them as you deem fit.

## Optional Enhancements

1. You can modify the workflow to suit your needs. You can insert mode rule-based nodes, change orgainsation of screenshots in destination folders. Particularly, you can try to increase classification accuracy at 'Image Analysis' node possibly by,
   - modifying classification categories and their description in the OpenAI prompt
   - changing the OpenAI model being used, OR
   - enhancing the overall prompt and nudging to deep think and reason

2. Create your own n8n workflows using their pre-built tools/ nodes.


