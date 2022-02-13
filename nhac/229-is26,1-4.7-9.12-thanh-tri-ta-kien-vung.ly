% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Thành Trì Ta Kiên Vững" }
  composer = "Is. 26,1-4.7-9.12"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c' {
  \partial 4 c8 c |
  d4. e8 |
  f2 ~ |
  f8 f
  <<
    {
      d
    }
    \new Voice = "beSop" {
      \voiceTwo
      \stemDown
      \once \override NoteColumn.force-hshift = #-1.2
      \parenthesize
      e
    }
  >>
  \oneVoice
  d |
  a'4. fs8 |
  g4 r8 e16 e |
  a8 a a b |
  c4. d8 |
  g,4. fs16 g |
  d8 f e d |
  c4 r8 \bar "||" \break
  
  g' |
  e'4 e8. d16 |
  b8 c c
  \afterGrace a ({
    \override Flag.stroke-style = #"grace"
    g16)}
  \revert Flag.stroke-style
  g4 r8 e |
  e4 f8. d16 |
  d8 g e d |
  c4 \bar "|."
}

nhacPhienKhucAlto = \relative c'' {
  r4 |
  R2*9
  r4.
  g8 |
  c4 c8. f,16 |
  g8 a a [f] |
  e4 r8 c |
  c4 d8. c16 |
  b8 b b b |
  c4
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  <<
    {
      \set stanza = "1."
      Thành trì ta kiên vững,
      Chúa đặt tường lũy chở che.
      Mở cửa ra cho dân công chính tiến vào,
      Một dân tộc nghĩa trung trọn niềm.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
	    Đời đời luôn tin Chúa,
	    Núi \markup { \italic \underline "Đá" }
	    bền vững ngàn năm.
	    Kìa hiền nhân luôn đi theo lối chính trực,
	    Đường kẻ lành Chúa thương san bằng.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Chờ đợi luôn nơi Chúa,
	    Lối đường Ngài sẽ vạch ra.
	    Này hồn con miên man thao thức khát vọng,
	    Và luôn tưởng nhớ Tôn Danh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
	    Trọn từng đêm thao thức
	    Khát vọng tìm Chúa nào ngơi.
	    Người từ muôn phương tuân theo Chúa phán định,
	    Nhận ra đường lối công minh Ngài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Này đoàn con xin Chúa
	    Giữ gìn cuộc sống bình an.
	    Mọi việc do tay con dân Chúa đã làm,
	    Nhờ ơn Ngài giúp cho viên thành.
    }
  >>
  \set stanza = "ĐK:"
  Ngài quyết giữ dân này an cư lạc nghiệp,
  Vì họ vẫn một lòng vững tin nơi Ngài.
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
  \key c \major \time 2/4
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
    \override Lyrics.LyricSpace.minimum-distance = #1.5
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
