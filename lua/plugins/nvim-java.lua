local M = {
  'nvim-java/nvim-java',
  ft = 'java',
}

function M.config()
  local functions = require('functions')

  local home = os.getenv('HOME')

  local function runtimes()
    if functions.OS() == 'linux' then
      return {
        {
          name = "JavaSE-21",
          path = "/usr/lib/jvm/java-21-openjdk/",
        },
        {
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-openjdk/",
        },
      }
    else
      return {
        {
          name = "JavaSE-1.8",
          path = home .. "/.sdkman/candidates/java/8.0.382-amzn/",
        },
        {
          name = "JavaSE-11",
          path = home .. "/.sdkman/candidates/java/11.0.20-tem/",
        },
        {
          name = "JavaSE-17",
          path = home .. "/.sdkman/candidates/java/17.0.8-tem/",
        },
        {
          name = "JavaSE-21",
          path = home .. "/.sdkman/candidates/java/21.0.7-tem/",
        },
      }
    end
  end

  local rt = runtimes()

  -- local function j17_home()
  --   for _, p in ipairs(rt) do
  --     if p.name == "JavaSE-17" then
  --       return p.path
  --     end
  --   end
  -- end

  require('java').setup({
    jdk = {
      auto_install = false,
    },
    spring_boot_tools = {
      enable = true,
      version = '1.59.0',
    },
    java_test = {
      enable = true,
      version = '0.43.1',
    },
    java_debug_adapter = {
      enable = true,
      version = '0.58.2',
    },
    jdtls = {
      version = 'v1.46.1',
    },
  })
  require('lspconfig').jdtls.setup({
    handlers = {
      -- By assigning an empty function, you can remove the notifications
      -- printed to the cmd
      ["$/progress"] = function(_, result, ctx) end,
      ['language/status'] = function() end,
    },
    -- cmd_env =  {
    --   JAVA_HOME = j17_home(),
    --   PATH = vim.fn.getenv('PATH') .. ':' .. j17_home() .. "/bin",
    -- },
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
