% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Chúc Tụng Chúa Đi" }
  composer = "Đn. 3,57-88"
  %arranger = "Lm. Kim Long"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 8 f8 |
  c8. a'16 a8 a |
  f f4 g8 |
  g4 g8 g |
  e e4 f8 |
  f2 ~ |
  f4 \bar "||" \break
  
  \tuplet 3/2 { a8 f a } |
  g8. f16 f8 d |
  c4 \bar "" \break
  
  \tuplet 3/2 { d8 a c } |
  d8. f16 d8 g |
  a2 ~ |
  a4 \bar "" \break
  
  \tuplet 3/2 { bf8 g bf } |
  a8. f16 bf8 c |
  d4 \bar "" \break
  
  \tuplet 3/2 { d8 g, bf } |
  c8. c,16 g'8 f16 (e) |
  f2 ~ |
  f4 \bar "|."
}

nhacPhienKhucAlto = \relative c' {
  f8 |
  c8. f16 f8 f |
  d d4 d8 |
  c4 b!8 b |
  c c4 bf8 |
  a2 ~ |
  a4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "Mở đầu:"
  Muôn đời Chúa đáng chúc tụng và tôn vinh,
  đáng chúc tụng và tôn vinh.
  
  \override Lyrics.LyricText.font-series = #'bold
  Chúc tụng Chúa đi
  \revert Lyrics.LyricText.font-series
  <<
    {
      uy công của Ngài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    cơ binh trên trời
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    khí nóng, lửa hồng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    ban đêm, ban ngày
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    non cao, nương đồi
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    vương ngue, thủy tộc
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    nhân gian trên đời
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    ai yêu công bình
    }
  >>
  
  \override Lyrics.LyricText.font-series = #'bold
  Hát mừng Ngài đi
  \revert Lyrics.LyricText.font-series
  <<
    {
	    muôn vị thiên sứ
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    muôn ngàn tinh tú
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    bao trận giông bão
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    huy hoàng, tăm tối
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    cây cỏ hoa lá
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    bao loài chim chóc
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Ít -- ra -- en hỡi
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    chư vị khiêm ái
    }
  >>
  
  \override Lyrics.LyricText.font-series = #'bold
  Chúc tụng Chúa đi
  \revert Lyrics.LyricText.font-series
  <<
    {
      trời cao muôn lớp
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    vầng ô, trăng sáng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    thời đông băng giá.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    ngàn mây, sấm chớp
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    kìa bao con suối,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    nào muôn gia súc,
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    nào muôn tư tế.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    từ trời cao sáng.
    }
  >>
  
  \override Lyrics.LyricText.font-series = #'bold
  Hát mừng Ngài đi
  \revert Lyrics.LyricText.font-series
  <<
    {
      nguồn nước trên không.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    mọi lớp mưa sương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    nào tuyết sương rơi.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    mặt đất muôn phương.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    biển lớn sông sâu.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    cầm thú, sơn lâm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    nào các tôi trung.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Một Chúa Ba Ngôi.
    }
  >>
}

loiPhienKhucSopN = \lyrics {
  <<
    {
      Hãy tạ ơn Chúa, vì Chúa nhân từ
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chúa làm nhên những việc rất phi thường
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chúa tạo nên những đén lớn trên trời
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Giết sạch con trưởng toàn cõi Ai -- cập
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chúa đà phân rẽ triều nước biển Hồng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Dẫn đường dân Chúa ở giữa sa mạc
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chiềm bờ cõi chúng và đã trao tặng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chúa giật ta thoát khỏi lũ quân thù
    }
  >>
  \set stanza = "ĐK:"
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
  
  <<
    {
      Hãy cảm mến Ngài là Chúa các Chúa
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chính Ngài tác tạo trời xanh bao la
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Vẫn điều khiển ngày là kim ô đây
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Dẫn khỏi xứ này toàn dân "Ít-ra-" en
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Dẫn tôi tớ Ngài bình yên băng quan
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Đấng đã đánh phạt nhiều vua uy phong
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Để thành kỷ phân của Ít -- ra -- en
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Đấng nuôi dưỡng hoài ngàn muôn sinh linh
    }
  >>
  \set stanza = "ĐK:"
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
  
  <<
    {
      Hãy tạ ơn Chúa, Thần của chư thần
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Chúa đà căng đất ở giữa thủy triều
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Với ngàn tinh tú dọi sáng đêm trường
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Với bàn tay Chúa mạnh mẽ uy quyền
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Nhần chìm vương tướng dòng giống Ai Cập
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Giết sạch vương bá quyền thế oai hùng
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Giữa thời nguy khó Ngài nhớ ta hoài
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    Hãy tạ ơn Chúa ngự chốn cửu trùng
    }
  >>
  \override Lyrics.LyricText.font-series = #'bold
  Muôn đời Chúa vẫn trọn tình thương
  \revert Lyrics.LyricText.font-series
}

% Dàn trang
\paper {
  #(set-paper-size "a5")
  top-margin = 3\mm
  bottom-margin = 3\mm
  left-margin = 3\mm
  right-margin = 3\mm
  indent = #0
  #(define fonts
	 (make-pango-font-tree "Deja Vu Serif Condensed"
	 		       "Deja Vu Serif Condensed"
			       "Deja Vu Serif Condensed"
			       (/ 20 20)))
  print-page-number = ##f
  system-system-spacing = #'((basic-distance . 0.1) (padding . 3))
}

TongNhip = {
  \key f \major \time 2/4
  \set Timing.beamExceptions = #'()
  \set Timing.baseMoment = #(ly:make-moment 1/4)
}

% Đổi kích thước nốt cho bè phụ
notBePhu =
#(define-music-function (font-size music) (number? ly:music?)
   (for-some-music
     (lambda (m)
       (if (music-is-of-type? m 'rhythmic-event)
           (begin
             (set! (ly:music-property m 'tweaks)
                   (cons `(font-size . ,font-size)
                         (ly:music-property m 'tweaks)))
             #t)
           #f))
     music)
   music)

\score {
  \new ChoirStaff <<
    \new Staff \with {
        \consists "Merge_rests_engraver"
        printPartCombineTexts = ##f
      }
      <<
      \new Voice \TongNhip \partCombine 
        \nhacPhienKhucSop
        \notBePhu -1 { \nhacPhienKhucAlto }
      \new NullVoice = beSop \nhacPhienKhucSop
      \new Lyrics \lyricsto beSop \loiPhienKhucSop
      >>
  >>
  \layout {
    %\override Staff.TimeSignature.transparent = ##t
    \override Lyrics.LyricSpace.minimum-distance = #0.6
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
