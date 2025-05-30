return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    enabled = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("xcodebuild").setup({
        restore_on_start = false, -- logs, diagnostics, and marks will be loaded on VimEnter (may affect performance)
        auto_save = true, -- save all buffers before running build or tests (command: silent wa!)
        show_build_progress_bar = true, -- shows [ ...    ] progress bar during build, based on the last duration
        prepare_snapshot_test_previews = false, -- prepares a list with failing snapshot tests
        test_search = {
          file_matching = "filename_lsp", -- one of: filename, lsp, lsp_filename, filename_lsp. Check out README for details
          target_matching = true, -- checks if the test file target matches the one from logs. Try disabling it in case of not showing test results
          lsp_client = "sourcekit", -- name of your LSP for Swift files
          lsp_timeout = 200, -- LSP timeout in milliseconds
        },
        commands = {
          -- extra_build_args = { "-parallelizeTargets" }, -- extra arguments for `xcodebuild build`
          -- extra_test_args = { "-parallelizeTargets" }, -- extra arguments for `xcodebuild test`
          project_search_max_depth = 2, -- maxdepth of xcodeproj/xcworkspace search while using configuration wizard
          focus_simulator_on_app_launch = false, -- focus simulator window when app is launched
          keep_device_cache = false, -- keep device cache even if scheme or project file changes
        },
        logs = { -- build & test logs
          enabled = false,
          auto_open_on_success_tests = false, -- open logs when tests succeeded
          auto_open_on_failed_tests = false, -- open logs when tests failed
          auto_open_on_success_build = false, -- open logs when build succeeded
          auto_open_on_failed_build = true, -- open logs when build failed
          auto_close_on_app_launch = true, -- close logs when app is launched
          auto_close_on_success_build = true, -- close logs when build succeeded (only if auto_open_on_success_build=false)
          auto_focus = true, -- focus logs buffer when opened
          filetype = "", -- file type set for buffer with logs
          open_command = "silent botright 20split {path}", -- command used to open logs panel. You must use {path} variable to load the log file
          logs_formatter = "xcbeautify --disable-colored-output --disable-logging", -- command used to format logs, you can use "" to skip formatting
          only_summary = true, -- if true logs won't be displayed, just xcodebuild.nvim summary
          live_logs = false, -- if true logs will be updated in real-time
          show_warnings = false, -- show warnings in logs summary
          notify = function(message, severity) -- function to show notifications from this module (like "Build Failed")
            vim.notify(message, severity)
          end,
          notify_progress = function(message) -- function to show live progress (like during tests)
            vim.cmd("echo '" .. message .. "'")
          end,
        },
        console_logs = {
          enabled = false, -- enable console logs in dap-ui
          format_line = function(line) -- format each line of logs
            return line
          end,
          filter_line = function(line) -- filter each line of logs
            return true
          end,
        },
        marks = {
          show_signs = true, -- show each test result on the side bar
          success_sign = "✔", -- passed test icon
          failure_sign = "✖", -- failed test icon
          show_test_duration = true, -- show each test duration next to its declaration
          show_diagnostics = true, -- add test failures to diagnostics
        },
        quickfix = {
          show_errors_on_quickfixlist = true, -- add build/test errors to quickfix list
          show_warnings_on_quickfixlist = false, -- add build warnings to quickfix list
        },
        test_explorer = {
          enabled = false, -- enable Test Explorer
          auto_open = true, -- open Test Explorer when tests are started
          auto_focus = true, -- focus Test Explorer when opened
          open_command = "botright 42vsplit Test Explorer", -- command used to open Test Explorer, must create a buffer with "Test Explorer" name
          open_expanded = true, -- open Test Explorer with expanded classes
          success_sign = "✔", -- passed test icon
          failure_sign = "✖", -- failed test icon
          progress_sign = "…", -- progress icon (only used when animate_status=false)
          disabled_sign = "⏸", -- disabled test icon
          partial_execution_sign = "‐", -- icon for a class or target when only some tests were executed
          not_executed_sign = " ", -- not executed or partially executed test icon
          show_disabled_tests = false, -- show disabled tests
          animate_status = true, -- animate status while running tests
          cursor_follows_tests = true, -- moves cursor to the last test executed
        },
        code_coverage = {
          enabled = false, -- generate code coverage report and show marks
          file_pattern = "*.swift", -- coverage will be shown in files matching this pattern
          -- configuration of line coverage presentation:
          covered_sign = "",
          partially_covered_sign = "┃",
          not_covered_sign = "┃",
          not_executable_sign = "",
        },
        code_coverage_report = {
          warning_coverage_level = 60,
          error_coverage_level = 30,
          open_expanded = false,
        },
        project_manager = {
          guess_target = true, -- guess target for the new file based on the file path
          find_xcodeproj = false, -- instead of using configured xcodeproj search for xcodeproj closest to targeted file
          should_update_project = function(path) -- path can lead to directory or file
            -- it could be useful if you mix Xcode project with SPM for example
            return true
          end,
          project_for_path = function(path)
            -- you can return a different project for the given {path} (could be directory or file)
            -- ex.: return "/your/path/to/project.xcodeproj"
            return nil
          end,
        },
        device_picker = {
          mappings = {
            move_up_device = "<M-y>", -- move device up in the list
            move_down_device = "<M-e>", -- move device down in the list
            add_device = "<M-a>", -- add device to cache
            delete_device = "<M-d>", -- delete device from cache
            refresh_devices = "<C-r>", -- refresh devices list
          },
        },
        integrations = {
          pymobiledevice = {
            enabled = false, -- enable pymobiledevice integration (requires configuration, see: `:h xcodebuild.remote-debugger`)
            remote_debugger_port = 65123, -- port used by remote debugger (passed to pymobiledevice3)
          },
          xcodebuild_offline = {
            enabled = true, -- improves build time (requires configuration, see `:h xcodebuild.xcodebuild-offline`)
          },
          xcode_build_server = {
            enabled = true, -- run "xcode-build-server config" when scheme changes
          },
          nvim_tree = {
            enabled = false, -- enable updating Xcode project files when using nvim-tree
          },
          neo_tree = {
            enabled = false, -- enable updating Xcode project files when using neo-tree.nvim
          },
          oil_nvim = {
            enabled = false, -- enable updating Xcode project files when using oil.nvim
          },
          quick = { -- integration with Swift test framework: github.com/Quick/Quick
            enabled = false, -- enable Quick tests support (requires Swift parser for nvim-treesitter)
          },
        },
      })
      vim.keymap.set({ "n", "v", "t" }, "<leader>xc", ":XcodebuildBuildRun<CR> ", { desc = "Xcode Build & Run" })
      vim.keymap.set(
        { "n", "v", "t" },
        "<leader>xd",
        ' :lua require("dapui").toggle()<CR>',
        { desc = "Xcode Build & Run" }
      )
    end,
  },
  {
    "mfussenegger/nvim-dap",
    enabled = true,
    dependencies = {
      "wojciech-kulik/xcodebuild.nvim",
    },
    config = function()
      local xcodebuild = require("xcodebuild.integrations.dap")
      -- SAMPLE PATH, change it to your local codelldb path
      local codelldbPath = os.getenv("HOME") .. "/Downloads/extension/adapter/codelldb"

      xcodebuild.setup(codelldbPath)

      -- vim.keymap.set("n", "<leader>dd", xcodebuild.build_and_debug, { desc = "Build & Debug" })
      -- vim.keymap.set("n", "<leader>dr", xcodebuild.debug_without_build, { desc = "Debug Without Building" })
      -- vim.keymap.set("n", "<leader>dt", xcodebuild.debug_tests, { desc = "Debug Tests" })
      -- vim.keymap.set("n", "<leader>dT", xcodebuild.debug_class_tests, { desc = "Debug Class Tests" })
      -- vim.keymap.set("n", "<leader>b", xcodebuild.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      -- vim.keymap.set("n", "<leader>B", xcodebuild.toggle_message_breakpoint, { desc = "Toggle Message Breakpoint" })
      -- vim.keymap.set("n", "<leader>dx", xcodebuild.terminate_session, { desc = "Terminate Debugger" })
    end,
  },
  {
    "rcarriga/nvim-dap-ui",
    enabled = true,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    lazy = true,
    config = function()
      require("dapui").setup({
        controls = {
          element = "repl",
          enabled = true,
          icons = {
            disconnect = "",
            run_last = "",
            terminate = "⏹︎",
            pause = "⏸︎",
            play = "",
            step_into = "󰆹",
            step_out = "󰆸",
            step_over = "",
            step_back = "",
          },
        },
        floating = {
          border = "single",
          mappings = {
            close = { "q", "<Esc>" },
          },
        },
        icons = {
          collapsed = "",
          expanded = "",
          current_frame = "",
        },
        layouts = {
          -- {
          --   elements = {
          --     { id = "stacks", size = 0.25 },
          --     { id = "scopes", size = 0.25 },
          --     { id = "breakpoints", size = 0.25 },
          --     { id = "watches", size = 0.25 },
          --   },
          --   position = "left",
          --   size = 40,
          -- },
          {
            elements = {
              { id = "repl", size = 0.4 },
              { id = "console", size = 0.6 },
              { id = "breakpoints", size = 0.25 },
            },
            position = "bottom",
            size = 10,
          },
        },
      })

      local dap, dapui = require("dap"), require("dapui")
      local group = vim.api.nvim_create_augroup("dapui_config", { clear = true })

      -- hide ~ in DAPUI
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = group,
        pattern = "DAP*",
        callback = function()
          vim.wo.fillchars = "eob: "
        end,
      })
      vim.api.nvim_create_autocmd("BufWinEnter", {
        group = group,
        pattern = "\\[dap\\-repl\\]",
        callback = function()
          vim.wo.fillchars = "eob: "
        end,
      })

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },
}
