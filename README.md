# n8n Workflow Runner

A simple setup to run n8n workflows locally on your Mac. This project provides a pre-built workflow that you can import and run immediately.

## What This Does

This project sets up n8n (a workflow automation platform) on your local machine using Docker. Once running, you can import and execute workflows without needing to understand the technical details.

## How It Works

1. **Setup**: Installs required tools (Docker, Node.js, pnpm) and starts n8n
2. **Import**: You import your workflow JSON file into n8n
3. **Run**: Execute the workflow through n8n's web interface

## Requirements
- macOS
- Git
- Terminal access
- Open API Key

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
   Select "Import from file" from the dropdown of the three dots (elipsis) on top right corner.
   Select the `screenshot_sorter.json` file from this repository to import.
   You will now see all the nodes in the workflow and their connections on the canvas.

3. **Add OpenAI Key**
   Notice the error indicator on 'Analyse image' node (find the node with OpenAI Icon). This is because n8n does not know which API key to use.
      - Double click on the 'Analyse image' node.
      - Click on the dropdown for 'Credentiial to connect with'.
      - If you do not already have one, click on 'Create New Credential'.
      - Paste your OpenAI API key in the API Key input box and hit 'Save'.
      - You should see a message 'Connection tested successfully'. Close the dialog box.
      - Go back to canvas and 'Save' the workflow.
   The workflow is now ready for execution.

4. **Execute the Workflow**
   Hover cursor over the first node 'Trigger Screenshot Sorter' and click on 'Execute workflow' button. This will run the workflow.
   If the workflow stops after processing a few images to to API rate limit, then pause for the time duration recommended in the error and 'Execute workflow' again.

5. **Review the Organised Screenshots**
   As the workflow progresses, you should find processed screenshots moved to folder called 'organised' and appropriately categorised in 'keep' or 'delete' folders.
   Feel free to review them and delete them as you deem fit.

## Optional Enhancements

1. You can modify the workflow to suit your needs - change the destination folder hierarchy, improve classification by enhancing openAI prompt, changing model, inserting specific rule-based nodes or passing more meta-data with image file etc.

2. Create your own n8n workflows using their pre-built tools/ nodes.


