local M = {
  'nvim-java/nvim-java',
  ft = 'java',
}

function M.config()
  local functions = require('functions')

  require('java').setup({
    jdk = {
      auto_install = true,
    },
  })
  require('lspconfig').jdtls.setup({
    handlers = {
      -- By assigning an empty function, you can remove the notifications
      -- printed to the cmd
      ["$/progress"] = function(_, result, ctx) end,
      ['language/status'] = function() end,
    },
    settings = {
      java = {
        configuration = {
          runtimes = rt,
          maven = {
            globalSettings = home .. '/.m2/settings.xml',
          },
        },
        import = {
          maven = {
            enabled = true,
            offline = { enabled = true },
          },
        },
        maven = {
          downloadSources = true,
          updateSnapshots = false, -- force updated of Snapshots/Releases
        },
        format = {
          -- curl -LO https://raw.githubusercontent.com/google/styleguide/gh-pages/eclipse-java-google-style.xml
          -- mv eclipse-java-google-style.xml $HOME/.config/
          settings = { url = home .. '/.config/eclipse-java-google-style.xml' }
        };
        signatureHelp = { enabled = true };
        contentProvider = { preferred = 'fernflower' };
        saveActions = {
          organizeImports = true,
        },
        implementationsCodeLens = {
          enabled = true
        },
        referencesCodeLens = {
          enabled = true
        },
        completion = {
          favoriteStaticMembers = {
            "org.assertj.core.api.Assertions.assertThat",
            "org.assertj.core.api.Assertions.assertThatThrownBy",
            "org.assertj.core.api.Assertions.assertThatExceptionOfType",
            "org.assertj.core.api.Assertions.catchThrowable",
            "org.hamcrest.MatcherAssert.assertThat",
            "org.hamcrest.Matchers.*",
            "org.hamcrest.CoreMatchers.*",
            "org.junit.jupiter.api.Assertions.*",
            "java.util.Objects.requireNonNull",
            "java.util.Objects.requireNonNullElse",
            "org.mockito.Mockito.*"
          },
          filteredTypes = {
            "com.sun.*",
            "io.micrometer.shaded.*",
            "java.awt.*",
            "jdk.*",
            "sun.*",
          },
        },
        sources = {
          organizeImports = {
            starThreshold = 9999;
            staticStarThreshold = 9999;
          },
        },
        codeGeneration = {
          toString = {
            template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
          },
          hashCodeEquals = {
            useJava7Objects = true,
          },
          useBlocks = true,
        },
      }
    }
  })
end

return M
