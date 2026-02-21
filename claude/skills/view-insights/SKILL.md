---
name: view-insights
description: Generate Claude Code usage insights and automatically open the report in the default browser. Use when the user wants to view their insights, view their usage report, see their Claude Code statistics, or asks to run /insights and open it, open insights report, or view insights in browser.
---

# View Insights

## Overview

This skill generates a Claude Code usage insights report and automatically opens it in the default browser for easy viewing.

## Workflow

Execute the following steps in sequence:

1. **Run the insights command**: Execute `/insights` to generate the usage report.

2. **Extract the report path**: Parse the output to find the HTML file path. The output will contain a line like:
   ```
   file:///Users/username/.claude/usage-data/report.html
   ```

3. **Open in browser**: Use the `open` command (macOS) or appropriate system command to open the HTML file in the default browser:
   ```bash
   open /path/to/report.html
   ```

## Example

When the user requests to view insights:

1. Run `/insights`
2. Look for the report path in the output (typically `~/.claude/usage-data/report.html`)
3. Execute `open <report-path>` to launch it in the browser
4. Confirm to the user that the report has been opened

## Notes

- The report path is consistent across runs: `~/.claude/usage-data/report.html`
- On macOS, use `open` command
- On Linux, use `xdg-open` command
- On Windows, use `start` command
