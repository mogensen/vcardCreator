## Use linux line feeds
set LF to {ASCII character 10}
tell application "Microsoft Excel"
	activate
	
	## Parameters to change
	set number_cells to {"Grp. nr.", "Postnr.", "Mobil", "Evt. fastnet/telefonnr.2"}
	
	set outFile to (path of active workbook)
	set fileName to (name of active workbook)
	set outFile to (outFile & ":" & fileName & ".csv")
	set openFile to open for access file outFile with write permission
	set eof openFile to 0
	set lastCol to count of columns of used range of active sheet
	set lastRow to count of rows of used range of active sheet
	
	set rowStr to "\"" & (value of cell 1 of column 1 of active sheet)
	repeat with c from 2 to lastCol
		set cellVal to (value of cell 1 of column c of active sheet)
		set rowStr to rowStr & "\",\"" & cellVal
	end repeat
	set rowStr to rowStr & "\""
	write rowStr & LF to openFile as Çclass utf8È
	
	repeat with r from 2 to lastRow
		
		# Handle first column
		if number_cells contains (value of cell 1 of column 1 of active sheet) then
			set rowStr to "\"" & ((value of cell r of column 1 of active sheet) as integer)
		else
			set rowStr to "\"" & (value of cell r of column 1 of active sheet)
		end if
		
		# All the res off the colums
		repeat with c from 2 to lastCol
			if number_cells contains (value of cell 1 of column c of active sheet) then
				set cellVal to ((value of cell r of column c of active sheet) as integer)
			else
				set cellVal to (value of cell r of column c of active sheet)
			end if
			set rowStr to rowStr & "\",\"" & cellVal
		end repeat
		
		set rowStr to rowStr & "\""
		write rowStr & LF to openFile as Çclass utf8È
	end repeat
	close access openFile
end tell