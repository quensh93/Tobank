# Stac CLI

The Stac CLI is a powerful command-line tool that helps you build, deploy, and manage Stac applications. It provides commands for authentication, project initialization, widget building, and deployment to Stac Cloud.

## Installation

### Global Installation

Install the Stac CLI globally:

```bash
npm install -g @stac/cli
```

### Local Installation

Install the Stac CLI locally in your project:

```bash
npm install --save-dev @stac/cli
```

### Using npx

Use the Stac CLI without installation:

```bash
npx @stac/cli --help
```

## Authentication

### Login

Authenticate with Stac Cloud:

```bash
stac login
```

This will open your browser to authenticate with your Stac Cloud account.

### Logout

Log out from Stac Cloud:

```bash
stac logout
```

### Whoami

Check your current authentication status:

```bash
stac whoami
```

## Project Management

### Initialize Project

Create a new Stac project:

```bash
stac init my-stac-app
cd my-stac-app
```

This creates a new project with the following structure:

```
my-stac-app/
├── stac.config.js
├── widgets/
│   ├── home.json
│   └── profile.json
├── themes/
│   ├── light.json
│   └── dark.json
└── assets/
    └── images/
```

### Project Configuration

Configure your project with `stac.config.js`:

```javascript
module.exports = {
  projectId: 'your-project-id',
  apiKey: 'your-api-key',
  baseUrl: 'https://api.stac.dev',
  widgets: {
    source: './widgets',
    output: './dist/widgets'
  },
  themes: {
    source: './themes',
    output: './dist/themes'
  },
  assets: {
    source: './assets',
    output: './dist/assets'
  }
};
```

## Widget Development

### Create Widget

Create a new widget:

```bash
stac create widget home
```

This creates a new widget file at `widgets/home.json`:

```json
{
  "type": "scaffold",
  "appBar": {
    "type": "appBar",
    "title": {
      "type": "text",
      "data": "Home"
    }
  },
  "body": {
    "type": "center",
    "child": {
      "type": "text",
      "data": "Welcome to Stac!"
    }
  }
}
```

### Build Widgets

Build your widgets for deployment:

```bash
stac build
```

This processes all widgets and outputs them to the `dist` directory.

### Watch Mode

Watch for changes and rebuild automatically:

```bash
stac build --watch
```

### Validate Widgets

Validate your widget JSON:

```bash
stac validate
```

This checks for:
- Valid JSON syntax
- Required widget properties
- Correct widget types
- Action configurations

## Theme Development

### Create Theme

Create a new theme:

```bash
stac create theme dark
```

This creates a new theme file at `themes/dark.json`:

```json
{
  "name": "Dark Theme",
  "colors": {
    "primary": "#BB86FC",
    "secondary": "#03DAC6",
    "background": "#121212",
    "surface": "#1E1E1E",
    "text": "#FFFFFF"
  },
  "typography": {
    "fontFamily": "Roboto",
    "headline1": {
      "fontSize": 32,
      "fontWeight": "bold"
    }
  }
}
```

### Build Themes

Build your themes:

```bash
stac build themes
```

### Preview Themes

Preview your themes in the browser:

```bash
stac preview themes
```

## Deployment

### Deploy to Stac Cloud

Deploy your widgets and themes to Stac Cloud:

```bash
stac deploy
```

This uploads your built widgets and themes to Stac Cloud.

### Deploy Specific Components

Deploy only widgets:

```bash
stac deploy --widgets
```

Deploy only themes:

```bash
stac deploy --themes
```

### Deploy with Environment

Deploy to a specific environment:

```bash
stac deploy --env production
```

### Rollback Deployment

Rollback to a previous deployment:

```bash
stac rollback
```

## Asset Management

### Upload Assets

Upload assets to Stac Cloud:

```bash
stac upload assets
```

### Sync Assets

Sync local assets with Stac Cloud:

```bash
stac sync assets
```

### Download Assets

Download assets from Stac Cloud:

```bash
stac download assets
```

## Development Tools

### Development Server

Start a local development server:

```bash
stac dev
```

This starts a local server that:
- Serves your widgets and themes
- Provides hot reloading
- Shows validation errors
- Enables local testing

### Preview Mode

Preview your widgets in the browser:

```bash
stac preview
```

### Linting

Lint your widgets and themes:

```bash
stac lint
```

This checks for:
- Code style issues
- Best practices
- Performance optimizations
- Accessibility concerns

### Testing

Run tests for your widgets:

```bash
stac test
```

## Configuration Options

### Environment Variables

Set environment variables for configuration:

```bash
export STAC_API_KEY=your-api-key
export STAC_PROJECT_ID=your-project-id
export STAC_BASE_URL=https://api.stac.dev
```

### Configuration File

Use a configuration file for complex setups:

```javascript
// stac.config.js
module.exports = {
  projectId: process.env.STAC_PROJECT_ID,
  apiKey: process.env.STAC_API_KEY,
  baseUrl: process.env.STAC_BASE_URL,
  widgets: {
    source: './widgets',
    output: './dist/widgets',
    watch: true
  },
  themes: {
    source: './themes',
    output: './dist/themes',
    watch: true
  },
  assets: {
    source: './assets',
    output: './dist/assets',
    watch: true
  },
  deployment: {
    environment: 'production',
    region: 'us-east-1'
  }
};
```

## Advanced Usage

### Custom Build Scripts

Create custom build scripts:

```javascript
// scripts/build.js
const { execSync } = require('child_process');

// Build widgets
execSync('stac build widgets', { stdio: 'inherit' });

// Build themes
execSync('stac build themes', { stdio: 'inherit' });

// Deploy
execSync('stac deploy', { stdio: 'inherit' });
```

### CI/CD Integration

Integrate with CI/CD pipelines:

```yaml
# .github/workflows/deploy.yml
name: Deploy to Stac Cloud

on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup Node.js
        uses: actions/setup-node@v2
        with:
          node-version: '16'
      - name: Install dependencies
        run: npm install
      - name: Build widgets
        run: stac build
      - name: Deploy to Stac Cloud
        run: stac deploy
        env:
          STAC_API_KEY: ${{ secrets.STAC_API_KEY }}
          STAC_PROJECT_ID: ${{ secrets.STAC_PROJECT_ID }}
```

### Custom Plugins

Create custom plugins for the CLI:

```javascript
// plugins/custom-plugin.js
module.exports = {
  name: 'custom-plugin',
  hooks: {
    'build:before': async (config) => {
      console.log('Running custom build step...');
    },
    'deploy:after': async (config) => {
      console.log('Custom deployment completed!');
    }
  }
};
```

## Troubleshooting

### Common Issues

1. **Authentication Failed**
   ```bash
   stac logout
   stac login
   ```

2. **Build Errors**
   ```bash
   stac validate
   stac lint
   ```

3. **Deployment Failed**
   ```bash
   stac deploy --verbose
   ```

### Debug Mode

Enable debug mode for detailed logging:

```bash
stac deploy --debug
```

### Verbose Output

Get detailed output from commands:

```bash
stac build --verbose
stac deploy --verbose
```

## Best Practices

### 1. Project Structure

Organize your project with a clear structure:

```
project/
├── stac.config.js
├── widgets/
│   ├── pages/
│   │   ├── home.json
│   │   └── profile.json
│   └── components/
│       ├── button.json
│       └── card.json
├── themes/
│   ├── light.json
│   └── dark.json
├── assets/
│   ├── images/
│   └── icons/
└── scripts/
    ├── build.js
    └── deploy.js
```

### 2. Version Control

Use version control for your widgets and themes:

```bash
git add widgets/ themes/
git commit -m "Add new widgets and themes"
git push origin main
```

### 3. Environment Management

Use different environments for development and production:

```bash
# Development
stac deploy --env development

# Production
stac deploy --env production
```

### 4. Automated Deployment

Set up automated deployment with webhooks:

```bash
stac webhook add https://api.example.com/deploy
```

## Next Steps

- [Examples](./11-examples.md) - See complete examples
- [API Reference](./12-api-reference.md) - Detailed API documentation
- [Contributing](./13-contributing.md) - Contribute to Stac
