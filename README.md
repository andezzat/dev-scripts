# 📟 dev-scripts

**A collection of productivity scripts for day-to-day dev workflows.**

## 🦸‍♂️ Super Commit

**A simple bash script to help you write [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/).**

_Powered & inspired by [Gum](https://github.com/charmbracelet/gum)!_

### ⚠️ Prerequisites

- [Brew](https://brew.sh/)
- [Gum](https://github.com/charmbracelet/gum) (_installed automatically via Brew_)

### 📦 Setup

```bash
wget https://raw.githubusercontent.com/andezzat/dev-scripts/main/super-commit.sh
chmod +x super-commit.sh
./super-commit.sh
```

![super-commit-setup](https://user-images.githubusercontent.com/1734293/182736405-39a2c449-8bc3-4271-ab54-3e5cb33cd7bb.gif)

### ✨ Usage

![super-commit-usage](https://user-images.githubusercontent.com/1734293/182736442-81124a56-7c74-4691-9ad8-a700d08b1ac6.gif)

_BONUS: If you prefix your branch names with an issue # eg. (tech-516), then it'll automatically pull it for you!_

### 🎨 Customization

#### Available Types & Scopes

```bash
# 👇 Customize the types & scopes available here 👇
TYPES="build chore ci docs feat fix perf refactor revert style test"
SCOPES="react-app react-native-app graphql-api config-api"
```

At the top of the script, you'll find vars setup for the available commit types & scopes.
Update the values, and you should see them being used next time you start up _Super Commit!_

#### Issue #

Issue # is a custom convention required at Kasada, but you can remove that quite easily if your repo/workplace doesn't follow it.

That's as far as it goes for now, might add more things in the future tho 😜 🤷
