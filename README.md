# Endless Apps Website

Web frontend for viewing first-party educational content apps for Endless OS.

## Data

Ideally we could download the data on demand when building, but for now I'm copying `/var/lib/flatpak/appstream/eos-apps/x86_64/active/appstream.xml` and `/var/lib/flatpak/appstream/eos-apps/x86_64/active/icons/` from an Endless OS install to the root of this repo.

## Building

This site is a simple Jekyll-powered site hosted by GitHub Pages. To run it locally, see [the GitHub docs](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/).

I recommend using `toolbox` to develop, especially if you're on Endless OS or Fedora Silverblue; see [this blog post](https://cassidyjames.com/blog/github-pages-jekyll-fedora-silverblue/) for details.

### Updating Apps

The list of apps is generated with a simple Ruby script. To rebuild the app list (e.g. if you've changed something in the Ruby script), run:

```shell
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
