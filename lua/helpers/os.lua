local M = {}

function M.isWindows()
  if jit.os.lower == 'windows' then
    return true
  else
    return false
  end
end

-- Adds .exe to binary name when on windows
function M.binName(binname)
  if M.isWindows then
    return (binname .. '.exe')
  else
    return binname
  end
end

return M
