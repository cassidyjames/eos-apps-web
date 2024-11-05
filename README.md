# Endless Apps Website

Web frontend for viewing first-party educational content apps for Endless OS.

## Data

Ideally we could download the data on demand when building, but for now I'm copying `/var/lib/flatpak/appstream/eos-apps/x86_64/active/appstream.xml` and `/var/lib/flatpak/appstream/eos-apps/x86_64/active/icons/` from an Endless OS install to the root of this repo and to `images/` respectively.

## Building

This site is a simple Jekyll-powered site hosted by GitHub Pages. To run it locally, see [the GitHub docs](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/).

I recommend using `toolbox` to develop, especially if you're on Endless OS or Fedora Silverblue; see [this blog post](https://cassidyjames.com/blog/github-pages-jekyll-fedora-silverblue/) for more details. But in brief, this should get you going:

```shell
toolbox enter
sudo dnf install ruby ruby-devel openssl-devel @development-tools gcc-c++
sudo gem install bundler
bundle install
```

You may need to manually install some gems, e.g.:

```shell
sudo dnf install rubygem-nokogiri rubygem-crack
```

Then to run:

```shell
bundle exec jekyll serve --host 0.0.0.0
```

### Updating Apps

The list of apps is generated with a simple Ruby script. To rebuild the app list, delete the existing files so any removals (e.g. end-of-life apps) are reflected, then run the script:

```shell
rm _apps/*
ruby generate-eos-apps.rb
```

This script is also automatically run on push to the `main` branch if the script itself, the AppStream data, or the icons change.

### Serve

```shell
bundle exec jekyll serve --host 0.0.0.0
```

The site should now be available at http://0.0.0.0:4000/ on your local machine, and your local machine's IP address on your network—great for testing on mobile OSes.

## Thanks

Thanks to [@gamerlv](https://github.com/gamerlv) for [the original script](https://gist.github.com/gamerlv/4bb5e59415f239e8c79ff1d473e54520) and [Ryan McNeely](https://github.com/RMcNeely) for the [initial Flatpak port](https://github.com/elementary/appcenter-web/pull/58)!
