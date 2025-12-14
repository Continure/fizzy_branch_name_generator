# Fizzy Branch Name Generator

A Rails application that generates GitHub branch names from Fizzy cards. Connect your Fizzy account, view your tasks, and get ready-to-use branch names in the format `number-task-name`.

## Features

- 🔗 **Fizzy API Integration** - Connect to your Fizzy account using access tokens
- 📋 **Task List View** - See all your Fizzy cards with automatically generated branch names
- 🔄 **Automatic Branch Name Generation** - Converts task titles to GitHub-friendly branch names
- 📋 **One-Click Copy** - Copy branch names to clipboard with a single click
- 🔗 **Direct Links** - Click on any card to open it in Fizzy
- 💾 **Token Persistence** - Access token is saved in session or environment variables

## How It Works

1. Enter your Fizzy access token (or set it in `.env` file)
2. Select or enter your account slug
3. View all cards with branch names, or enter a specific card number
4. Copy the generated branch name and use it in your Git workflow

Branch names are generated in the format: `number-task-name-slug` (e.g., `123-add-dark-mode-support`)

## Prerequisites

- Ruby (see `.ruby-version` for the required version)
- PostgreSQL
- Node.js (for JavaScript bundling)
- A Fizzy account with API access

## Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd fizzy_branch_name
```

2. Install dependencies:
```bash
bundle install
npm install
```

3. Set up the database:
```bash
rails db:create
rails db:migrate
```

4. Configure environment variables (optional):
Create a `.env` file in the root directory:
```bash
FIZZY_ACCESS_TOKEN=your-access-token-here
```

You can get your access token from Fizzy profile → API → Personal access tokens.

5. Start the server:
```bash
rails server
```

Visit `http://localhost:3000` to use the application.

## Configuration

### Environment Variables

- `FIZZY_ACCESS_TOKEN` - Your Fizzy API access token (optional, can be entered in the UI)
- `FIZZY_API_BASE_URL` - Fizzy API base URL (defaults to `https://app.fizzy.do`)

### Getting a Fizzy Access Token

1. Go to your Fizzy profile
2. Navigate to API → Personal access tokens
3. Click "Generate new access token"
4. Give it a description and select permissions (Read or Read + Write)
5. Copy the generated token

## Usage

### View All Cards

1. Enter your access token (if not set in `.env`)
2. Select or enter your account slug (e.g., `/897362094`)
3. Leave the card number field empty
4. Click "Load Cards"
5. Browse all your cards with their generated branch names

### View a Specific Card

1. Enter your access token (if not set in `.env`)
2. Enter your account slug
3. Enter the card number
4. Click "Load Cards"
5. See the card details and its branch name

### Copy Branch Name

Click the copy button next to any branch name to copy it to your clipboard. The button will show a checkmark when successful.

## Project Structure

```
app/
├── controllers/
│   └── branch_names_controller.rb    # Main controller
├── models/
│   ├── branch_name/
│   │   └── generator.rb               # Branch name generation logic
│   └── fizzy/
│       ├── client.rb                  # Fizzy API client
│       ├── api_error.rb
│       ├── not_found_error.rb
│       └── unauthorized_error.rb
├── views/
│   └── branch_names/
│       └── index.html.erb             # Main view
└── javascript/
    └── controllers/
        └── copy_controller.js         # Copy to clipboard functionality

config/
└── configs/
    ├── application_config.rb          # Base config class
    └── fizzy_config.rb                # Fizzy API configuration
```

## Technology Stack

- **Rails 8.1** - Web framework
- **PostgreSQL** - Database
- **Hotwire (Turbo + Stimulus)** - Frontend interactivity
- **Tailwind CSS** - Styling
- **HTTParty** - HTTP client for API requests
- **anyway_config** - Type-safe configuration management

## Development

### Running Tests

```bash
# Run all tests
rails test

# Run specific test file
rails test test/path/to/test_file.rb
```

### Code Style

This project follows Rails conventions and uses:
- `rubocop-rails-omakase` for Ruby linting
- Standard Rails code organization patterns

### API Documentation

See `API.md` for Fizzy API documentation.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is open source and available under the [MIT License](LICENSE).

## Support

For issues and questions:
- Check the [Fizzy API documentation](API.md)
- Review the code following [AGENTS.md](AGENTS.md) guidelines

---

Made with ❤️ using Rails
