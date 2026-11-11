# Rails Social Media

A simple social media website built with **Ruby on Rails**. This is a learning project where users can create posts, connect with friends, leave comments, and explore groups.

The goal is to practice building a real web application while learning how Rails models, controllers, views, databases, and user accounts work together.

> **Project status:** Learning / development project. Not yet recommended for public production deployment.

## What can this app do?

| Feature | Description |
| --- | --- |
| User accounts | Register, log in, and log out with Devise |
| Social login | Code for Facebook, GitHub, and Google login (requires provider credentials and setup) |
| Posts | Create, edit, and delete your own posts |
| Images | Upload an image with a post |
| Post privacy | Choose Public, Private, or Friends only |
| Feed | See visible posts, newest first, or filter to My posts |
| Comments | Write, edit, and delete your own comments |
| Friends | Send, accept, decline, or cancel friend requests; remove friends |
| Groups | Create groups with a name, description, and banner; manage groups you own |

### Understanding post privacy

- **Public:** Any signed-in user can see the post.
- **Private:** Only the person who created it can see it.
- **Friends only:** The creator and users with an accepted friendship can see it.

The current feed requires a login. These privacy settings are intended to apply to the feed and post comments.

## Technologies used

| Technology | Why it is used |
| --- | --- |
| Ruby 3.0.4 | Programming language |
| Ruby on Rails 7 | Main web application framework |
| MySQL | Stores users, posts, comments, and friendships |
| ERB | Builds HTML pages using Ruby |
| Bootstrap 5 | Styles the interface |
| JavaScript, Turbo, Stimulus | Frontend behavior |
| Devise | User registration and authentication |
| Pundit | Authorization checks |
| CarrierWave | Image uploads |
| OmniAuth | Social sign-in integrations |

**Note:** The project uses older Ruby/Rails dependencies. Ruby 3.0 is no longer supported. Upgrading dependencies is recommended before deploying publicly.

## Getting started (beginner-friendly)

You will run the project on your own computer. These instructions assume the repository's current Ruby, Rails, and MySQL setup.

### Step 1 — Install the required software

Install the following:

1. **Git** — https://git-scm.com/downloads
2. **Ruby 3.0.4** and **Bundler** — https://www.ruby-lang.org/en/downloads/
3. **MySQL Server** — https://dev.mysql.com/downloads/
4. **Node.js** — https://nodejs.org/
5. **Yarn** — https://yarnpkg.com/

**Windows users:** A Linux environment such as WSL2 (Ubuntu) is recommended for this older Rails project. Ruby and native gems such as `mysql2` can be harder to configure directly on Windows. Install Ruby, MySQL development libraries, Node.js, and Yarn inside WSL if you choose that route.

Open a terminal and check the installations:

```bash
ruby -v
bundle -v
mysql --version
node -v
yarn --version
git --version
```

Ruby should report version **3.0.4** to match this repository. If a command is not recognized, install or configure that tool before continuing.

### Step 2 — Download the project

Open a terminal and run:

```bash
git clone https://github.com/bryn-espiritu/rails-social-media.git
cd rails-social-media
```

This downloads the code and opens the project folder.

If you already cloned it earlier, open the existing folder and run `git pull` to get the latest changes.

### Step 3 — Install the Ruby gems

Inside the project folder, run:

```bash
bundle install
```

Bundler downloads the Ruby libraries listed in `Gemfile` and `Gemfile.lock`.

If installation fails, check your Ruby version and ensure MySQL development headers and a working C compiler are installed. The `mysql2` gem needs them.

### Step 4 — Install frontend packages

Run:

```bash
yarn install
```

This installs Bootstrap, Turbo, Stimulus, esbuild, Sass, and other packages from `package.json`.

### Step 5 — Configure MySQL

Start your local MySQL server. You need a MySQL username and password that can create databases.

The Rails app reads its database connection from environment variables. **Do not write your actual password into the repository.**

For macOS, Linux, or a WSL terminal:

```bash
export DB_HOST=localhost
export DB_USERNAME=root
export DB_PASSWORD='your_mysql_password'
export DB_NAME=social_media
export DB_TEST_NAME=social_media_test
```

Replace `your_mysql_password` with your own local MySQL password. These settings apply to the current terminal session.

For **Windows PowerShell**, use this format instead:

```powershell
$env:DB_HOST="localhost"
$env:DB_USERNAME="root"
$env:DB_PASSWORD="your_mysql_password"
$env:DB_NAME="social_media"
$env:DB_TEST_NAME="social_media_test"
```

If MySQL runs in a separate Docker container, `DB_HOST` may need to be the database service name instead of `localhost`.

### Step 6 — Create the database

Run:

```bash
bin/rails db:prepare
```

This prepares the development database and loads the database structure.

If it reports **Access denied**, check the MySQL username and password. If it reports **Can't connect**, make sure MySQL is running and `DB_HOST` is correct.

### Step 7 — Start the website

Run:

```bash
bin/dev
```

This starts the Rails server and the JavaScript/CSS build watchers using the project's `Procfile.dev`. The script may install Foreman the first time.

Open your browser and visit:

**http://localhost:3000**

You should see the app's login page or social feed. Create an account to begin.

To stop the server, press **Ctrl + C** in the terminal.

**If `bin/dev` fails:** First try `bin/rails server` and open the same address. You may also need separate terminals for `yarn build --watch` and `yarn build:css --watch` to see the intended styling and JavaScript.

## How to use the website

### Create a post

1. Register or log in.
2. Click **Create post**.
3. Enter a title and some content.
4. Optionally upload an image.
5. Choose Public, Private, or Friends only.
6. Submit the form.

Your new post should appear in the appropriate feed.

### View your posts

The home feed offers two choices:

- **All visible posts** — posts you are allowed to see.
- **My posts** — posts you created, including private posts.

### Add a comment

1. Find a post you can view.
2. Click **Comments**.
3. Click **Add comment**.
4. Type your comment and save it.

You can edit or delete your own comments, but not someone else's.

### Add a friend

1. Open **Requests** from the navigation.
2. Find a user in the Explore section.
3. Click **Add Friend**.
4. The other user can accept or decline the request.

After a request is accepted, both users can see each other's Friends-only posts.

### Create a group

1. Open **Groups**.
2. Click **Create group**.
3. Enter a name and description.
4. Optionally upload a banner.
5. Save the group.

Group owners can edit and delete their groups. More advanced group membership features are planned for future improvements.

## Project structure

These are the main folders you will work with as you learn Rails:

```text
rails-social-media/
├── app/
│   ├── controllers/     # Handles requests and user actions
│   ├── models/          # Database records and relationships
│   ├── views/           # Pages shown in the browser
│   ├── policies/        # Permissions and authorization
│   ├── uploaders/       # Image upload handling
│   ├── assets/          # Styles and other assets
│   └── javascript/      # Frontend JavaScript
├── config/
│   ├── routes.rb        # Website URLs
│   └── database.yml     # Database configuration
├── db/                  # Database schema and migrations
├── test/                # Rails tests (where present)
├── Gemfile              # Ruby dependencies
├── package.json         # JavaScript dependencies
├── Procfile.dev         # Local development processes
└── README.md            # This guide
```

**Example:** When someone creates a post, the browser sends a request to `PostsController`. The controller uses the `Post` model to save information in MySQL. An ERB view then displays the post.

## How to test the project

Start by checking the Rails commands:

```bash
bin/rails routes
RAILS_ENV=test bin/rails db:prepare
bin/rails test
```

In PowerShell, set `$env:RAILS_ENV="test"` before running the database and test commands. Set it back to `development` afterward.

**Manual test checklist**

- [ ] Create two different accounts.
- [ ] Log in and log out successfully.
- [ ] Create a public post and confirm the other account can see it.
- [ ] Create a private post and confirm only its author can see it.
- [ ] Create a Friends-only post, accept a friend request, and confirm the friend can see it.
- [ ] Edit and delete a post you own.
- [ ] Confirm another account cannot edit or delete your post.
- [ ] Add, edit, and delete a comment.
- [ ] Send, accept, decline, and cancel friend requests.
- [ ] Create a group and check owner-only editing.
- [ ] Check the layout on desktop and mobile screens.

**Testing status:** This README does not mean all tests have passed. The application still needs to be run and verified in a configured environment.

## Common problems and solutions

| Problem | What to try |
| --- | --- |
| `bundle install` fails | Confirm Ruby 3.0.4 and required native build tools are installed |
| MySQL connection error | Start MySQL and check `DB_HOST`, username, and password |
| Database does not exist | Run `bin/rails db:prepare` |
| Port 3000 already in use | Stop the other server or use `bin/rails server -p 3001` |
| Page has missing styles | Run `yarn install` and `yarn build:css` |
| JavaScript interactions fail | Run `yarn build` and check the browser console |
| Social login does not work | Configure the appropriate OAuth provider credentials and callback settings |
| Image upload fails | Check the uploader configuration and file permissions |

If something still fails, copy the **first meaningful error message** from the terminal. It usually identifies the missing dependency or configuration.

## Security and project limitations

This project is primarily for learning. Before making it publicly accessible:

- Upgrade Ruby, Rails, and outdated dependencies.
- Keep database passwords and OAuth credentials out of Git.
- Rotate the database password that was previously committed if it was ever used outside a disposable local environment. Changing the latest file does not erase Git history.
- Test permissions for posts, comments, friend requests, and groups.
- Review OAuth login, image uploads, and group membership behavior.
- Add automated model and request tests.

## Ideas for future features

- User profiles with avatars and bios
- Likes and reactions
- Notifications for new comments and friend requests
- Search for people and posts
- Pagination for long feeds
- Group joining and invitations
- Better mobile layouts
- Automated tests with GitHub Actions

## About this project

This is a personal learning project built to explore web development and understand how social media applications work. It is not intended to be a complete replacement for a professional social networking platform.

Feedback, suggestions, and contributions are welcome through GitHub issues and pull requests.

**Repository:** https://github.com/bryn-espiritu/rails-social-media
