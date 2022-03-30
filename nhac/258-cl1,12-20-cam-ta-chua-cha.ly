% Cài đặt chung\
\version "2.22.1"
\include "english.ly"

\header {
  title = \markup { \fontsize #1 "Cảm Tạ Chúa Cha" }
  composer = "Cl. 1,12-20"
  tagline = ##f
}

% Nhạc phiên khúc
nhacPhienKhucSop = \relative c'' {
  g8 e f d |
  c8. c16 e8 a |
  g4 r8 g16 g |
  a8 a a b |
  c4. c8 |
  a a4 c8 |
  g4 r8 d |
  f8. f16 e8 e |
  a4. a8 |
  b g a (b) |
  c2 ~ |
  c8 \bar "||" \break
  
  e,8 e e |
  f8. g16 a8 g |
  e4 d8 e |
  f8. e16 c8 c |
  <<
    {
      \voiceOne
      a'4
    }
    \new Voice = "splitpart" {
      \voiceTwo
      \once \override NoteColumn.force-hshift = #1.5
      \tweak font-size #-2
      \parenthesize
      g
    }
  >>
  \oneVoice
  r8 c |
  b8. b16 b8 b |
  c g ( g4 ^~ |
  g8) e d f |
  f8. f16 b,8 b |
  d c (c4 _~ |
  c) r \bar "||"
}

nhacPhienKhucAlto = \relative c'' {
  g8 e f d |
  c8. c16 c8 f |
  e4 r8 e16 e |
  f8 f f d |
  e4. e8 |
  f fs4 a8 |
  e4 r8 b |
  d8. d16 c8 c |
  f4. fs8 |
  g8 e d (g) |
  e2 ~ |
  e8
}

% Lời phiên khúc
loiPhienKhucSop = \lyrics {
  \set stanza = "ĐK:"
  Chúng ta hãy dâng lời cảm tạ Chúa Cha,
  đã làm cho ta nên xứng đáng tham dự phần gia nghiệp
  Dành cho ai thuộc về Chúa trong cõi đầy ánh sáng.
  <<
    {
      \set stanza = "1."
      Được gọi vào ở vương quốc Con Người,
      được giải thoát uy quyền mờ tối,
      Ta rầy được hưởng phần cứu độ
      lại được miễn thứ hết tội tình muôn vàn.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "2."
      \override Lyrics.LyricText.font-shape = #'italic
	    Người là hình ảnh Thiên Chúa vô hình,
	    là Trưởng Tử muôn loài thọ
	    \markup { \italic \underline "sinh," }
	    trong Người vạn vật được tác thành,
	    trên trời dưới đất hữu hình và vô hình.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "3."
	    Dù là thần chủ uy dũng thiên tòa đều nhờ bởi,
	    cho Người mà có,
	    muôn sự đều tồn tại trong Người,
	    Đây Người có trước các vật và muôn loài.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "4."
      \override Lyrics.LyricText.font-shape = #'italic
	    Là Đầu nhiệm thể hay Giáo Hội Người,
	    là Trưởng Từ trong hàng kẻ chết,
	    Trong mọi sự Người hằng đứng đầu
	    Trong Người Chúa muốn tất cả được viên thành.
    }
    \new Lyrics {
	    \set associatedVoice = "beSop"
	    \set stanza = "5."
	    Nhờ Người hòa giải cho khắp muôn vật,
	    nhờ bửu huyết tuôn trào thập giá,
	    An bình rầy được Người tái lập
	    Muôn vật dưới đất với vạn sự trên trời.
    }
  >>
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
    \override Lyrics.LyricSpace.minimum-distance = #1
    \override Score.BarNumber.break-visibility = ##(#f #f #f)
    \override Score.SpacingSpanner.uniform-stretching = ##t
  } 
}
