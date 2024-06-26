local jdtls = require('jdtls')
local root_markers = { 'gradlew', '.git', 'pom.xml', 'mvnw' }
local root_dir = require('jdtls.setup').find_root(root_markers)
local functions = require('functions')

local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
-- And search for `interface RuntimeOption`
-- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
local function runtimes()
  if functions.OS() == 'linux' then
    return {
      {
        name = "JavaSE-11",
        path = "/usr/lib/jvm/java-11-openjdk/",
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
    }
  end
end

local function mk_config()
  return {
    flags = {
      debounce_text_changes = 150,
      allow_incremental_sync = true,
      server_side_fuzzy_completion = true,
    };
    handlers = {},
    on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true }
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>di", "<Cmd>lua require('jdtls').organize_imports()<CR>", opts)

      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>de", "<Cmd>lua require('jdtls').extract_variable()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>de", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", opts)

      vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>dm", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", opts)

      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dc", "<Cmd>lua require('jdtls').extract_constant()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "v", "<leader>dc", "<Esc><Cmd>lua require('jdtls').extract_constant(true)<CR>", opts)

      -- If using nvim-dap
      -- This requires java-debug and vscode-java-test bundles
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dt", "<Cmd>lua require('jdtls').test_class()<CR>", opts)
      vim.api.nvim_buf_set_keymap(bufnr, "n", "<leader>dn", "<Cmd>lua require('jdtls').test_nearest_method()<CR>", opts)

      -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
      -- you make during a debug session immediately.
      -- Remove the option if you do not want that.
      -- You can use the `JdtHotcodeReplace` command to trigger it manually
      jdtls.setup_dap({ hotcodereplace = 'auto' })
      require('jdtls.setup').add_commands()

    end;
    settings = {},
  }
end

local config = mk_config()
local rt = runtimes()
config.settings = {
  java = {
    maxConcurrentBuilds = 2,
    import = {
      maven = {
        enabled = true,
        offline = { enabled = true },
      },
    },
    jdt = {
      ls = {
        lombokSupport = { enabled = true },
        androidSupport = { enabled = false },
      },
    },
    maven = {
      downloadSources = true,
      updateSnapshots = false, -- force updated of Snapshots/Releases
    },
    references = {
      includeAccessors = true,
      -- includeDecompiledSources = true,
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
    };
    sources = {
      organizeImports = {
        starThreshold = 9999;
        staticStarThreshold = 9999;
      };
    };
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    };
    configuration = {
      maven = {
        globalSettings = home .. '/.m2/settings.xml',
      },
      runtimes = rt
    };
  };
}

-- local function java()
--   if functions.OS() == 'linux' then
--     return '/usr/lib/jvm/java-17-openjdk/bin/java'
--   else
--     return '/Library/Java/JavaVirtualMachines/temurin-17.jdk/Contents/Home/bin/java'
--   end
-- end

-- lombok support
-- wget https://projectlombok.org/downloads/lombok.jar
-- mv lombok.jar $HOME/.local/share/eclipse/
config.cmd = {
  home .. '/.local/share/nvim/mason/packages/jdtls/bin/jdtls',
  '--jvm-arg=-javaagent:' .. home .. '/.local/share/eclipse/lombok.jar',
  '-configuration', home .. '/.cache/jdtls',
  '-data', workspace_folder,
}

local function j17_home()
  for _, p in ipairs(rt) do
    if p.name == "JavaSE-17" then
      return p.path
    end
  end
end

-- run the jdtls with java 17
config.cmd_env = {
  JAVA_HOME = j17_home(),
}

-- java-debug
-- git clone git@github.com:microsoft/java-debug.git
-- ./mvnw clean install
-- vscode-java-test
-- git clone git@github.com:microsoft/vscode-java-test.git
-- npm install
-- npm run build-plugin
local bundles = {
  vim.fn.glob(home .. "/.local/share/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
};
vim.list_extend(bundles, vim.split(vim.fn.glob(home .. "/.local/share/vscode-java-test/server/*.jar", 1), "\n"))
config.init_options = {
  bundles = bundles;
}

local extendedClientCapabilities = jdtls.extendedClientCapabilities;
extendedClientCapabilities.resolveAdditionalTextEditsSupport = true;
config.init_options = {
  bundles = bundles;
  extendedClientCapabilities = extendedClientCapabilities;
}

jdtls.start_or_attach(config)
